import 'package:flutter/material.dart';

class SessionCreatorScreen extends StatefulWidget {
  const SessionCreatorScreen({super.key});

  @override
  State<SessionCreatorScreen> createState() => _SessionCreatorScreenState();
}

class _SessionCreatorScreenState extends State<SessionCreatorScreen> {
  final TextEditingController nameController = TextEditingController();

  String selectedMode = "soft";
  int selectedMinutes = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Session"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          /// 🧠 Session Name
          const Text("Session Name"),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "e.g. Deep Study",
            ),
          ),

          const SizedBox(height: 20),

          /// ⏱ Duration
          const Text("Duration (Minutes)"),
          Slider(
            value: selectedMinutes.toDouble(),
            min: 15,
            max: 180,
            divisions: 11,
            label: "$selectedMinutes",
            onChanged: (value) {
              setState(() {
                selectedMinutes = value.toInt();
              });
            },
          ),

          const SizedBox(height: 20),

          /// 🔒 Mode
          const Text("Mode"),
          Column(
            children: [
              RadioListTile<String>(
              title: const Text("Soft"),
              value: "soft",
              groupValue: selectedMode,
              onChanged: (value) {
              if (value == null) return;
             setState(() {
            selectedMode = value;
          });
         },
        ),
             RadioListTile<String>(
              title: const Text("Soft"),
              value: "soft",
              groupValue: selectedMode,
              onChanged: (value) {
              if (value == null) return;
             setState(() {
            selectedMode = value;
          });
         },
        ),
              RadioListTile<String>(
              title: const Text("Soft"),
              value: "soft",
              groupValue: selectedMode,
              onChanged: (value) {
              if (value == null) return;
             setState(() {
            selectedMode = value;
          });
         },
        ),
            ],
          ),

          const SizedBox(height: 20),

          /// 🚀 Create Button
          ElevatedButton(
            onPressed: () {
              debugPrint("Session Created");
            },
            child: const Text("Create Session"),
          ),
        ],
      ),
    );
  }
}