//
//  BLEStack.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import UIKit
import CoreBluetooth


class BLEStack : NSObject
{
    
    static var shared : BLEStack = BLEStack()
    
    var mainVC = MainVC()
    
    var centralManager : CBCentralManager!
    var peripheral : CBPeripheral!
    var peripheralManager : CBPeripheralManager!
    
    var peripheralArray : [BluetoothPeriperal] = []
    var selected : BluetoothPeriperal?
    var selectedUUID : UUID?
    
    var characteristicList : [CBCharacteristic] = []
        
    var deviceReloadDelegate : DeviceReloadDelegate?
    var sensorDataUpdateDelegate : SensorDataUpdateDelegate?
    var recordSensorDataDelegate : RecordSensorDataDelegate?
    
    var connectedFlag : Bool = false
    
    override init()
    {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

}



