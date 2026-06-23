import 'dart:convert';
import 'package:flutter/services.dart';
import 'app_item_model.dart';

class AppsService {
  static const MethodChannel _channel =
      MethodChannel('com.zeroscroll.app/apps');

  Future<List<AppItem>> getInstalledApps() async {
    final result = await _channel.invokeMethod('getInstalledApps');

    return (result as List).map((app) {
      return AppItem(
        name: app['name'],
        packageName: app['package'],
      );
    }).toList();
  }

  String decodeIcon(String base64Icon) {
    return base64Icon;
  }
}