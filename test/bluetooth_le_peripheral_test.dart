import 'package:flutter_test/flutter_test.dart';
import 'package:bluetooth_le_peripheral/bluetooth_le_peripheral.dart';
import 'package:bluetooth_le_peripheral/bluetooth_le_peripheral_platform_interface.dart';
import 'package:bluetooth_le_peripheral/bluetooth_le_peripheral_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBluetoothLePeripheralPlatform
    with MockPlatformInterfaceMixin
    implements BluetoothLePeripheralPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> start(String payload) {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}

void main() {
  final BluetoothLePeripheralPlatform initialPlatform =
      BluetoothLePeripheralPlatform.instance;

  test('$MethodChannelBluetoothLePeripheral is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBluetoothLePeripheral>());
  });

  test('getPlatformVersion', () async {
    BluetoothLePeripheral bluetoothLePeripheralPlugin = BluetoothLePeripheral();
    MockBluetoothLePeripheralPlatform fakePlatform =
        MockBluetoothLePeripheralPlatform();
    BluetoothLePeripheralPlatform.instance = fakePlatform;

    expect(bluetoothLePeripheralPlugin.toString(), '42');
  });
}
