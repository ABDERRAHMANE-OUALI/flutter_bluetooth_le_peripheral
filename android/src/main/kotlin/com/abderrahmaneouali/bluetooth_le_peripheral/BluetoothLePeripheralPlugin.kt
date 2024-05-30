package com.abderrahmaneouali.bluetooth_le_peripheral

import android.content.Context
import android.hardware.camera2.CameraExtensionSession.StillCaptureLatency
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BluetoothLePeripheralPlugin */
class BluetoothLePeripheralPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context : Context? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bluetooth_le_peripheral")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun onMethodCall(call: MethodCall, result: Result) {
    var bluetoothPeripheralManager = BluetoothPeripheralManager()
    var args = call.arguments as HashMap<String, Any>
    if (call.method == "start") {
      bluetoothPeripheralManager.start(context!!, args.get("payload") as String)
      result.success(null)
    } else if (call.method == "stop"){
      bluetoothPeripheralManager.stop()
      result.success(null)
    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    context = null;
  }
}
