//
//  ViewController.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/01/22.
//

import UIKit
import Charts

class MainVC: UIViewController
{
    
    @IBOutlet weak var wValueLabel: UILabel!
    @IBOutlet weak var xValueLabel: UILabel!
    @IBOutlet weak var yValueLabel: UILabel!
    @IBOutlet weak var zValueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var lightSwitch: UISwitch!
    
    var dataBox = DataBox()

    var recordPressed : Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        BLEStack.shared.sensorDataUpdateDelegate = self
        BLEStack.shared.recordSensorDataDelegate = self
        BLEStack.shared.mainVC = self
    }
    
    // responsible for connecting and disconnecting
    @IBAction func connectButtonPressed(_ sender: UIButton) {
        if connectButton.titleLabel?.text == "Connect"
        {
            let bleConnectVC = self.storyboard?.instantiateViewController(identifier: ID.bleConnectVC)
            guard let nextVC = bleConnectVC
            else
            {
                print("Invalid View Controller")
                return
            }
            self.present(nextVC, animated: true, completion: nil)
        }
        else
        {
            BLEStack.shared.centralManager.cancelPeripheralConnection(BLEStack.shared.selected!.peripheral)
            connectButton.setTitle("Connect", for: .normal)
        }
        
    }
    
    
    @IBAction func recordButtonPressed(_ sender: UIButton)
    {
        // Start Recording
        if(recordPressed == false)
        {
            dataBox.clear()
            recordPressed = true
            recordButton.setTitle("Stop", for: .normal)
        }
        // Stop Recording
        else
        {
            recordPressed = false
            recordButton.setTitle("Record", for: .normal)
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
    
    @IBAction func lightSwitched(_ sender: UISwitch)
    {
        if lightSwitch.isOn
        {
            // peripheral is connected peripheral
            BLEStack.shared.writeOutgoingValue(data: "<on>")
        }
        else{
            BLEStack.shared.writeOutgoingValue(data: "<off>")
        }
    }
}


extension MainVC : SensorDataUpdateDelegate
{
    func updateLabel()
    {
        wValueLabel.text = String(SingletonBlackboard.shared.data.dataW)
        xValueLabel.text = String(SingletonBlackboard.shared.data.dataX)
        yValueLabel.text = String(SingletonBlackboard.shared.data.dataY)
        zValueLabel.text = String(SingletonBlackboard.shared.data.dataZ)
    }
}

// whenever new data from BLEStack refreshed, append data
extension MainVC : RecordSensorDataDelegate
{
    func recordOnCondition()
    {
        if recordPressed == true
        {
            dataBox.append()
        }
    }
}






