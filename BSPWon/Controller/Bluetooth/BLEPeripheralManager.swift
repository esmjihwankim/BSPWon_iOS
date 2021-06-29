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
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        if let characterstics = service.characteristics{
            for characteristic in characterstics as [CBCharacteristic]
            {
                if characteristic.properties.contains(CBCharacteristicProperties.notify)
                {
                    peripheral.readValue(for: characteristic)
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?)
    {
        if characteristic.isNotifying
        {
            characteristicList.append(characteristic as CBCharacteristic)
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
        guard let resultArray = DataConversion.bleSensorStringToNumberArray(data: encodedStringSensorData) else
        {
            print("invalid data type received from device")
            return
        }
        
        print(resultArray)
        
        // Update Singleton instance
        SingletonBlackboard.shared.rawString = encodedStringSensorData
        SingletonBlackboard.shared.data.dataW = resultArray[0]
        SingletonBlackboard.shared.data.dataX = resultArray[1]
        SingletonBlackboard.shared.data.dataY = resultArray[2]
        SingletonBlackboard.shared.data.dataZ = resultArray[3]
        
        // Signal MainVC via Delegate to record values
        sensorDataUpdateDelegate?.updateLabel()
        recordSensorDataDelegate?.recordOnCondition()

    }
    
    
    /* Writing Value to Peripheral */
    
    // Turn LED on/off by writing to bluetooth
    func writeOutgoingValue(data: String){
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        if let currentPeripheral = self.peripheral {
            let currentCharacteristic = characteristicList[0]
            currentPeripheral.writeValue(valueString!, for: currentCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("WRITE::\(characteristic)")
    }
    
    
}
