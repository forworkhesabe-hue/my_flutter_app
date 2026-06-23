class AppItem {
  final String name;
  final String packageName;
  final bool isSystemApp;

  const AppItem({
    required this.name,
    required this.packageName,
    this.isSystemApp = false,
  });
}