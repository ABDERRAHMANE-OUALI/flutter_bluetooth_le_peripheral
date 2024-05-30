import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluetooth_le_peripheral_platform_interface.dart';

/// An implementation of [BluetoothLePeripheralPlatform] that uses method channels.
class MethodChannelBluetoothLePeripheral extends BluetoothLePeripheralPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bluetooth_le_peripheral');

  @override
  Future<void> start(String payload) async {
    await methodChannel.invokeMethod<String>('start', {"payload": payload});
  }

  @override
  Future<void> stop() async {
    await methodChannel.invokeMethod<String>('stop');
  }
}
