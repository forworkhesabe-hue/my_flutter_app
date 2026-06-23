package com.zeroscroll.app

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityService.GLOBAL_ACTION_HOME
import android.content.Intent
import android.content.SharedPreferences
import android.view.accessibility.AccessibilityEvent
import android.content.Context
import org.json.JSONArray

class ZeroScrollAccessibilityService : AccessibilityService() {

    private lateinit var prefs: SharedPreferences

    override fun onServiceConnected() {
        super.onServiceConnected()
        // 🔐 الاتصال بملف تخزين فلاتر الرسمي
        prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return

        val packageName = event.packageName?.toString() ?: return

        // 🛡️ خطوط الدفاع: تجاهل تطبيقنا، واجهة النظام، والـ Launcher الرئيسي
        if (packageName == applicationContext.packageName) return
        if (packageName.contains("systemui")) return

        // 🧠 فحص إذا كانت جلسة التركيز نشطة حالياً
        val isSessionActive = prefs.getBoolean("flutter.session_active", false)
        if (!isSessionActive) return

        // 📱 قراءة قائمة التطبيقات المحظورة المستلمة من فلاتر (تأتي كـ JSON Array في SharedPreferences)
        val blockedAppsString = prefs.getString("flutter.blocked_apps", null) ?: return
        val blockedApps = mutableListOf<String>()
        
        try {
            val jsonArray = JSONArray(blockedAppsString)
            for (i in 0 until jsonArray.length()) {
                blockedApps.add(jsonArray.getString(i))
            }
        } catch (e: Exception) {
            // حماية الخدمة من التوقف في حال حدث خطأ أثناء القراءة
            return
        }

        // 🔒 تنفيذ الحظر الفوري وإظهار شاشة القفل العائمة
        if (blockedApps.contains(packageName)) {
            performGlobalAction(GLOBAL_ACTION_HOME)

            val intent = Intent(this, OverlayLockActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        }
    }

    override fun onInterrupt() {}
}