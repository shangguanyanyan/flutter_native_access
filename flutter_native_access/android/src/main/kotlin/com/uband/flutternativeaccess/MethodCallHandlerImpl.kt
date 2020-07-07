package com.uband.flutternativeaccess

import android.app.Activity
import android.content.Context
import android.view.WindowManager
import com.uband.native.access.flutter_native_access.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodCallHandlerImpl(var applicationContext: Context,
                            var methodChannel: MethodChannel) : MethodChannel.MethodCallHandler {
    lateinit var activity: Activity

    constructor(applicationContext: Context,
                activity: Activity,
                methodChannel: MethodChannel) : this(applicationContext, methodChannel) {
        this.activity = activity
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            GET_PLATFORM_VERSION -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            KEEP_SCREEN_ON -> call.argument<Boolean>(IS_KEEP_SCREEN_ON).let { it ->
                if (it == null) {
                    result.error("result", "传递参数：isKeepScreenOn值为null", null)
                } else {
                    isKeepScreenOn(it)
                    result.success(true)
                }
            }
            else -> result.notImplemented()
        }
    }
    /// 保持屏幕常亮
    private fun isKeepScreenOn(isKeepScreenOn: Boolean) {
        if (isKeepScreenOn) {
            activity.window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        } else {
            activity.window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }
}