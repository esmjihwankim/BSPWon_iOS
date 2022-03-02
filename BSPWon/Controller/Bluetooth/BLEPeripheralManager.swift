//
//  BLEPeripheralManager.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation
import CoreBluetooth

//MARK: - Bluetooth Peripheral Manager Delegate

extension BLEStack : CBPeripheralDelegate
{
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        for service in peripheral.services!
        {
            print("DID_DISCOVER_SERVICE:::", service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        if let characterstics = service.characteristics
        {
            for c in characterstics as [CBCharacteristic]
            {
                print("DID_DISCOVER_CHARACTERISTICS:::", c)
                if c.properties.contains(CBCharacteristicProperties.notify)
                {
                    //peripheral.readValue(for: characteristic)
                    peripheral.setNotifyValue(true, for: c)
                    self.receiveCharacteristic = c
                }
                // Store the characteristic into the instance array
                if c.properties.contains(CBCharacteristicProperties.writeWithoutResponse)
                {
                    self.transmitCharacteristic = c
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?)
    {
        if characteristic.isNotifying
        {
            peripheral.readValue(for: characteristic)
            print("UUID: \(characteristic.uuid)")
            print("property: \(characteristic.properties)")
        }
    }
    
    // When value of characteristics is updated
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    {
        
        // Data sent as nus_string from nRF52 converting to uint16 type
        guard let data = characteristic.value else { return }
        guard let encodedStringSensorData = String(data: data, encoding: .utf8)
        else
        {
            print("encoding failed")
            return
        }
        
        // Perform String Parsing Algorithm
        let resultArray = DataConversion.bleSensorStringToNumberArray(data: encodedStringSensorData)
        print(resultArray)
        
        // Update Singleton instance
        SingletonBlackboard.shared.data.dataU = resultArray[0]
        SingletonBlackboard.shared.data.dataV = resultArray[1]
        SingletonBlackboard.shared.data.dataW = resultArray[2]
        SingletonBlackboard.shared.data.dataX = resultArray[3]
        SingletonBlackboard.shared.data.dataY = resultArray[4]
        SingletonBlackboard.shared.data.dataZ = resultArray[5]
        SingletonBlackboard.shared.data.pulseInfo = resultArray[6]
        
        // Signal MainVC via Delegate to record values
        sensorDataUpdateDelegate?.updateSensorValue()
        recordSensorDataDelegate?.recordOnCondition()
    }
    
    
    /* Writing Value to Peripheral */
    
    // Turn LED on/off by writing to bluetooth
    func writeValue(data: String)
    {
        print("value outgoing:::", data)
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        if let currentPeripheral = self.peripheral
        {
            guard let currentCharacteristic = transmitCharacteristic else { return print("transmit characteristics not found") }
            currentPeripheral.writeValue(valueString!, for: currentCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
    {
        print("WRITE::\(characteristic)")
    }
    
}
