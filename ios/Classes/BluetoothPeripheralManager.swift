//
//  BluetoothPeripheralManager.swift
//  bluetooth_le_peripheral
//
//  Created by ABDERRAHMANE OUALI on 5/5/2024.
//

import Foundation
import CoreBluetooth

class BluetoothPeripheralManager: NSObject{
    var peripheralManager: CBPeripheralManager
    
    override init() {
        self.peripheralManager = CBPeripheralManager(delegate: nil, queue: nil)
    }
    
    func start(payload: String) {
        // Runs after 1 second on the main queue.
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400) ) {
            let payloadData = payload.data(using: .utf8)

             // 1. Create instance of CBMutableCharcateristic
            let myChar1 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID(uuidString: "6c84fb90-12c4-11e1-840d-7b25c5ee775a")!), properties: [.read],value: payloadData, permissions: [.readable])
            
            // 2. Create instance of CBMutableService
            var service = CBUUID(nsuuid: UUID(uuidString: "110ec58a-a0f2-4ac4-8393-c866d813b8d1")!)
            let myService = CBMutableService(type: service, primary: true)
            
            // 3. Add characteristics to the service
            myService.characteristics = [myChar1]
            
            // 4. Add service to peripheralManager
            self.peripheralManager.add(myService)
            
            // 5. Start advertising
            self.peripheralManager.startAdvertising([CBAdvertisementDataLocalNameKey : "BLEPeripheralApp", CBAdvertisementDataServiceUUIDsKey :     [service]])
            print("Started Advertising")

        }

    }
    
    func stop(){
        peripheralManager.stopAdvertising()
    }
}
