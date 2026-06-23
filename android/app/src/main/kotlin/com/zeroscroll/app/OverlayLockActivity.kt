package com.zeroscroll.app

import android.app.Activity
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.graphics.Color
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.TextView

class OverlayLockActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val layout = LinearLayout(this)
        layout.orientation = LinearLayout.VERTICAL
        layout.setBackgroundColor(Color.BLACK)
        layout.gravity = Gravity.CENTER

        val title = TextView(this)
        title.text = "🔒 Focus Mode Active"
        title.setTextColor(Color.WHITE)
        title.textSize = 22f
        title.gravity = Gravity.CENTER

        val message = TextView(this)
        message.text = "You chose focus.\nStay consistent."
        message.setTextColor(Color.LTGRAY)
        message.textSize = 16f
        message.gravity = Gravity.CENTER

        layout.addView(title)
        layout.addView(message)

        setContentView(layout)

        Handler(Looper.getMainLooper()).postDelayed({
            finish()
        }, 2500)
    }
}