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
    
    var centralManager : CBCentralManager!
    var peripheral : CBPeripheral!
    
    var peripheralArray : [BluetoothPeriperal] = []
    var selected : BluetoothPeriperal?
    var selectedUUID : UUID?
    
    var characteristicArray : [CBCharacteristic] = []
    var measurementValue : [[AnyObject]] = [[]]
    
    var deviceReloadDelegate : DeviceReloadDelegate?
    var sensorDataUpdateDelegate : SensorDataUpdateDelegate?
    var recordSensorDataDelegate : RecordSensorDataDelegate?
    
    override init()
    {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}



