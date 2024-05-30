package com.abderrahmaneouali.bluetooth_le_peripheral

import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothGatt
import android.bluetooth.BluetoothGattCallback
import android.bluetooth.BluetoothGattCharacteristic
import android.bluetooth.BluetoothGattServer
import android.bluetooth.BluetoothGattServerCallback
import android.bluetooth.BluetoothGattService
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.bluetooth.le.AdvertiseCallback
import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.bluetooth.le.BluetoothLeAdvertiser
import android.content.Context
import android.os.Build
import android.os.ParcelUuid
import android.util.Log
import androidx.annotation.RequiresApi
import java.util.UUID
import java.util.logging.Logger

class BluetoothPeripheralManager {


    private var bluetoothManager: BluetoothManager? = null;
    private var bluetoothAdvertiserManager: BluetoothLeAdvertiser? = null;
    private var bluetoothGattServer: BluetoothGattServer? = null;



    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun start(context: Context, payload: String){
        bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager;
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU){
            @Suppress("DEPRECATION")
            bluetoothManager?.adapter?.enable()
        }

        val rxCharacteristic = BluetoothGattCharacteristic(
            UUID.fromString("6c84fb90-12c4-11e1-840d-7b25c5ee775a"),
            BluetoothGattCharacteristic.PROPERTY_READ,
            BluetoothGattCharacteristic.PERMISSION_READ
        )

        val service = BluetoothGattService(
                    UUID.fromString("110ec58a-a0f2-4ac4-8393-c866d813b8d1"),
                    BluetoothGattService.SERVICE_TYPE_PRIMARY,
        )
        service.addCharacteristic(rxCharacteristic)
        bluetoothAdvertiserManager = bluetoothManager?.adapter?.bluetoothLeAdvertiser

        bluetoothGattServer = bluetoothManager
            ?.openGattServer(context, object :BluetoothGattServerCallback(){
                override fun onCharacteristicReadRequest(
                    device: BluetoothDevice?,
                    requestId: Int,
                    offset: Int,
                    characteristic: BluetoothGattCharacteristic?
                ) {
                    super.onCharacteristicReadRequest(device, requestId, offset, characteristic)
                    bluetoothGattServer?.sendResponse(device, requestId, 0, offset, payload.toByteArray())
                }
            })

        bluetoothGattServer?.addService(service)

        bluetoothAdvertiserManager?.startAdvertising(AdvertiseSettings.Builder().setConnectable(true).setAdvertiseMode(2).build(),
            AdvertiseData.Builder().addServiceUuid(ParcelUuid(UUID.fromString("110ec58a-a0f2-4ac4-8393-c866d813b8d1"))).build(),
            object: AdvertiseCallback(){})

    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun stop(){
        bluetoothGattServer?.close();
        bluetoothAdvertiserManager?.stopAdvertising(object : AdvertiseCallback(){});
    }
}