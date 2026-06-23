import '../../../core/apps/app_item_model.dart';

class AppSelectionController {
  final List<AppItem> _selectedApps = [];

  List<AppItem> get selectedApps => _selectedApps;

  void toggleApp(AppItem app) {
    final exists = _selectedApps.indexWhere(
      (a) => a.packageName == app.packageName,
    );

    if (exists >= 0) {
      _selectedApps.removeAt(exists);
    } else {
      _selectedApps.add(app);
    }
  }

  bool isSelected(AppItem app) {
    return _selectedApps.any(
      (a) => a.packageName == app.packageName,
    );
  }

  void clear() {
    _selectedApps.clear();
  }
}