//
//  BluetoothData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import Foundation
import CoreBluetooth

struct BluetoothPeriperal {
    var name : String
    var peripheral : CBPeripheral
    
    init(name: String, peripheral: CBPeripheral){
        self.name = "\(name)"
        self.peripheral = peripheral
    }
}

