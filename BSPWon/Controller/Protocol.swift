//
//  Protocols.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import Foundation

//MARK: - For BLEConnectVC
// updating device list when new device detected
protocol DeviceReloadDelegate {
    func reloadView()
}

//MARK: - For MainVC
// updating the follwing:
// value of x y z label
protocol SensorDataUpdateDelegate {
    func updateLabel()
}

