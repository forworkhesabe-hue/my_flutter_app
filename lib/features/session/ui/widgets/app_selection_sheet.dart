import 'package:flutter/material.dart';
import '../../../../core/apps/app_item_model.dart';
import '../../../../core/apps/app_group_model.dart';
import '../../../../core/apps/apps_service.dart';
import '../../controller/app_selection_controller.dart';

class AppSelectionSheet extends StatefulWidget {
  const AppSelectionSheet({super.key});

  @override
  State<AppSelectionSheet> createState() => _AppSelectionSheetState();
}

class _AppSelectionSheetState extends State<AppSelectionSheet> {
  // 🧠 استدعاء الـ Controller المسؤول عن إدارة الاختيارات
  late final AppSelectionController controller;

@override
void initState() {
  super.initState();
  controller = AppSelectionController();
}
  List<AppGroup> selectedGroups = [];

  // ⚙️ دالة جلب التطبيقات من الـ Service (التي تتصل بـ Kotlin)
  Future<List<AppItem>> _loadApps() async {
    final service = AppsService();
    return await service.getInstalledApps();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          const Text(
            "Select Apps & Groups",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          /// 🔥 Groups Section (الـ Presets السريعة)
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Groups", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _groupChip("Social"),
              _groupChip("Video"),
              _groupChip("Games"),
              _groupChip("Productivity"),
            ],
          ),
          const Divider(height: 32),

          /// 📱 Apps Section (عرض التطبيقات الحقيقية من الهاتف)
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Installed Apps", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: FutureBuilder<List<AppItem>>(
              future: _loadApps(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No apps found"));
                }

                final apps = snapshot.data!;

                return ListView.builder(
                  itemCount: apps.length,
                  itemBuilder: (context, index) {
                    final app = apps[index];
                    final isAppSelected = controller.isSelected(app);

                    // 🎯 نظام الـ Tap-to-Select الاحترافي (B)
                    return ListTile(
                      onTap: () {
                        setState(() {
                          controller.toggleApp(app);
                        });
                      },
                      leading: const Icon(Icons.android, color: Colors.blueGrey),
                      title: Text(app.name),
                      subtitle: Text(app.packageName, maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: Icon(
                        isAppSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isAppSelected ? Colors.green : Colors.grey,
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          /// 🚀 زر التأكيد وإرجاع البيانات المحددة
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              onPressed: () {
                Navigator.pop(context, {
                  "apps": controller.selectedApps,
                  "groups": selectedGroups,
                });
              },
              child: const Text("Confirm Selection"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupChip(String name) {
    return FilterChip(
      label: Text(name),
      selected: false,
      onSelected: (value) {
        // لاحقاً سيرتبط بـ المجموعات الجاهزة للـ Mapping
      },
    );
  }
}