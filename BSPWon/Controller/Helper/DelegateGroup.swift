//
//  Protocols.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import Foundation

//MARK: - For BLEConnectVC
// updating device list when new device detected
protocol DeviceReloadDelegate
{
    func reloadView()
}

//MARK: - Updating label in MainVC
// updating the follwing:
// value of x y z label
protocol SensorDataUpdateDelegate
{
    func updateSensorValue()
}

//MARK: - Recording data received from another object if button pressed
// recording means to append data in array
protocol RecordSensorDataDelegate
{
    func recordOnCondition()
}

//MARK: -
//
protocol BluetoothLogDelegate
{
    func displayLogOnUI()
}
