package com.zeroscroll.app

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.graphics.drawable.BitmapDrawable
import android.graphics.Bitmap
import android.util.Base64
import java.io.ByteArrayOutputStream

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.zeroscroll.app/apps"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getInstalledApps") {
                    result.success(getInstalledApps())
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun getInstalledApps(): List<Map<String, String>> {
        val pm: PackageManager = packageManager
        val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)
        val resultList = mutableListOf<Map<String, String>>()

        for (app in apps) {
            // تجاهل تطبيقات النظام غير المرئية في الواجهة
            if (pm.getLaunchIntentForPackage(app.packageName) == null) continue

            val appName = pm.getApplicationLabel(app).toString()
            val icon = pm.getApplicationIcon(app)
            val iconBase64 = drawableToBase64(icon)

            val map = mapOf(
                "name" to appName,
                "package" to app.packageName,
                "icon" to iconBase64
            )
            resultList.add(map)
        }
        return resultList
    }

    private fun drawableToBase64(drawable: android.graphics.drawable.Drawable): String {
        val bitmap = (drawable as BitmapDrawable).bitmap
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
        val byteArray = stream.toByteArray()
        return Base64.encodeToString(byteArray, Base64.DEFAULT)
    }
}