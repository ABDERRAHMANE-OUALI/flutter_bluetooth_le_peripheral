import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bluetooth_le_peripheral_method_channel.dart';

abstract class BluetoothLePeripheralPlatform extends PlatformInterface {
  /// Constructs a BluetoothLePeripheralPlatform.
  BluetoothLePeripheralPlatform() : super(token: _token);

  static final Object _token = Object();

  static BluetoothLePeripheralPlatform _instance =
      MethodChannelBluetoothLePeripheral();

  /// The default instance of [BluetoothLePeripheralPlatform] to use.
  ///
  /// Defaults to [MethodChannelBluetoothLePeripheral].
  static BluetoothLePeripheralPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BluetoothLePeripheralPlatform] when
  /// they register themselves.
  static set instance(BluetoothLePeripheralPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> start(String payload) {
    throw UnimplementedError('start() has not been implemented.');
  }

  Future<void> stop() {
    throw UnimplementedError('stop() has not been implemented.');
  }
}
