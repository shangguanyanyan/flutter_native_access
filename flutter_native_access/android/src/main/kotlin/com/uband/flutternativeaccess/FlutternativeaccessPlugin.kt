package com.uband.flutternativeaccess

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.uband.native.access.flutter_native_access.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutternativeaccessPlugin */
public class FlutternativeaccessPlugin() : FlutterPlugin, ActivityAware {
    private val TAG = "flutter_native_access"
    private lateinit var methodChannel: MethodChannel
    private lateinit var methodCallHandler: MethodCallHandlerImpl

    init {
        log("init plugin:${this}")
    }

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        setupMethodChannel(binding.binaryMessenger, binding.applicationContext)
        log("attached to engine\nplugin:$this\ncontext:${methodCallHandler.applicationContext}")
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val flutterNativeAccessPlugin = FlutternativeaccessPlugin()
            flutterNativeAccessPlugin.setupMethodChannel(registrar.activity(), registrar.messenger(), registrar.context())
            log("register with $registrar")
        }
    }

    private fun setupMethodChannel(binaryMessenger: BinaryMessenger, context: Context) {
        methodChannel = MethodChannel(binaryMessenger, PLUGIN_NAME)
        methodCallHandler = MethodCallHandlerImpl(context, methodChannel)
        methodChannel.setMethodCallHandler(methodCallHandler)
    }

    private fun setupMethodChannel(activity: Activity, binaryMessenger: BinaryMessenger, context: Context) {
        setupMethodChannel(binaryMessenger, context)
        methodCallHandler.activity = activity
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodCallHandler.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        log("onDetachedFromActivityForConfigChanges")
    }
    
}

fun log(message: String) {
    Log.d("nativeAccess", message)
}
