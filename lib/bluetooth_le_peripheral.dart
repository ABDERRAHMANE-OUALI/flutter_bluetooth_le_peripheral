import 'bluetooth_le_peripheral_platform_interface.dart';

class BluetoothLePeripheral {
  Future<void> start(String payload) {
    return BluetoothLePeripheralPlatform.instance.start(payload);
  }

  Future<void> stop() {
    return BluetoothLePeripheralPlatform.instance.stop();
  }
}
