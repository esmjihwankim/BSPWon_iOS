//
//  BLECentralManager.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation
import CoreBluetooth

//MARK: - Bluetooth Central Manager Delegate

extension BLEStack : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        print("Central State Update")
        if central.state != .poweredOn
        {
            print("Central state is not powered on");
        }
        else
        {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                       advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        var sameFlag : Bool = false
        if let peripheralName = peripheral.name
        {
            for i in 0 ..< peripheralArray.count
            {
                if peripheralArray[i].name == peripheralName
                {
                    sameFlag = true
                }
            }
            if(sameFlag == false)
            {
                peripheralArray.append(BluetoothPeriperal(name: peripheralName, peripheral: peripheral))
                // reload
                deviceReloadDelegate?.reloadView()
                print(peripheralArray)
            }
        }
    }
    
    func connectToDevice() {
        if let connectingUUID = selectedUUID
        {
            for i in 0 ..< peripheralArray.count
            {
                if peripheralArray[i].peripheral.identifier == connectingUUID
                {
                    centralManager?.connect(peripheralArray[i].peripheral, options: nil)
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    {
        print("Connected!")
        peripheralArray.removeAll()
        
        centralManager?.stopScan()
        print("Scan stopped")
                
        self.mainVC.connectButton.setTitle("Disconnect", for: .normal)
        peripheral.delegate = self
        selected!.peripheral.discoverServices(nil)
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?)
    {
        print("Failed to Connect")
    }
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
    {
        BLEStack.shared.peripheralArray.removeAll()
        BLEStack.shared.centralManager.scanForPeripherals(withServices: nil, options: nil)
        self.mainVC.connectButton.setTitle("Connect", for: .normal)
        deviceReloadDelegate?.reloadView()
        print("Disconnected")
    }
    
 
}
