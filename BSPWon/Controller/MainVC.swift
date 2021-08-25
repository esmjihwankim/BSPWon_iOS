//
//  ViewController.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/01/22.
//

import UIKit
import Dispatch

class MainVC: UIViewController
{
    
    @IBOutlet weak var wValueLabel: UILabel!
    @IBOutlet weak var xValueLabel: UILabel!
    @IBOutlet weak var yValueLabel: UILabel!
    @IBOutlet weak var zValueLabel: UILabel!
    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cascadeSwitch: UISwitch!
    @IBOutlet weak var pin1Switch: UISwitch!
    @IBOutlet weak var pin2Switch: UISwitch!
    
    @IBOutlet weak var plotView: PlotManager!

    var dataBox = DataBox()
    var recordPressed : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUI()
        BLEStack.shared.sensorDataUpdateDelegate = self
        BLEStack.shared.recordSensorDataDelegate = self
        BLEStack.shared.mainVC = self
        plotView.initGraph()
    }
    
    // responsible for connecting and disconnecting
    @IBAction func connectButtonPressed(_ sender: UIButton)
    {
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
            //TODO: Show Alert if not connected
            if BLEStack.shared.connectedFlag == false
            {
                AlertCall.showAlert(viewController: self, message: "Please connect to a device before recording", handler: nil)
                return
            }
            dataBox.clear()
            recordPressed = true
            recordButton.setTitle("Stop", for: .normal)
            recordButton.layer.backgroundColor = UIColor.systemRed.cgColor
        }
        // Stop Recording
        else
        {
            recordPressed = false
            recordButton.setTitle("Record", for: .normal)
            recordButton.layer.backgroundColor = UIColor.systemBlue.cgColor
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
//MARK: Switches for LED Neural Stimulation
    @IBAction func cascadeSwitchPressed(_ sender: UISwitch)
    {
        if cascadeSwitch.isOn
        {
            BLEStack.shared.writeValue(data: "<LEDCASCADEON>")
        }
        else
        {
            BLEStack.shared.writeValue(data: "<LEDCASCADEOFF>")
        }
    }
    
    @IBAction func pin1SwitchPressed(_ sender: UISwitch)
    {
        if pin1Switch.isOn
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN1ON>")
        }
        else
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN1OFF>")
        }
    }

    @IBAction func pin2SwitchPressed(_ sender: UISwitch) {
        if pin2Switch.isOn
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN2ON>")
        }
        else
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN2OFF>")
        }
    }
    
    // UI
    func setUI()
    {
        self.cascadeSwitch.isOn = false
        self.pin1Switch.isOn = false
        self.pin2Switch.isOn = false
        
        self.connectButton.layer.cornerRadius = 5.0
        self.connectButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.connectButton.tintColor = UIColor.white
        
        self.recordButton.layer.cornerRadius = 5.0
        self.recordButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.recordButton.tintColor = UIColor.white
    }
}


//MARK: Delegate Pattern for Updating value to UI
extension MainVC : SensorDataUpdateDelegate
{
    func updateSensorValue()
    {
        wValueLabel.text = String(SingletonBlackboard.shared.data.dataW)
        xValueLabel.text = String(SingletonBlackboard.shared.data.dataX)
        yValueLabel.text = String(SingletonBlackboard.shared.data.dataY)
        zValueLabel.text = String(SingletonBlackboard.shared.data.dataZ)
        
        
        self.plotView.drawPlotW()
        self.plotView.drawPlotX()
        self.plotView.drawPlotY()
        self.plotView.drawPlotZ()
    }
}

// whenever new data from BLEStack refreshed, append data
extension MainVC : RecordSensorDataDelegate
{
    func recordOnCondition()
    {
        if recordPressed == true
        {
            //print("append called")
            dataBox.append()
        }
    }
}






