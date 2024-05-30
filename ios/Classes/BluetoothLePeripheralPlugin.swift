import Flutter
import UIKit


public class BluetoothLePeripheralPlugin: NSObject, FlutterPlugin {
    
    private let bluetoothPeripheralManager: BluetoothPeripheralManager
    
    
    public override init() {
        bluetoothPeripheralManager = BluetoothPeripheralManager()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bluetooth_le_peripheral", binaryMessenger: registrar.messenger())
    let instance = BluetoothLePeripheralPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let args = call.arguments as? Dictionary<String, Any>
    switch call.method {
    case "start":
        startAdvertising(payload: args?["payload"] as? String ?? "", result: result)
    case "stop":
        stopAdvertising(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  
  }
    func startAdvertising(payload: String, result: @escaping FlutterResult){
        bluetoothPeripheralManager.start(payload: payload)
        result(nil)
    }
    func stopAdvertising(result: @escaping FlutterResult){
        bluetoothPeripheralManager.stop()
        result(nil)
    }
}
