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
    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var pulsingSwitch: UISwitch!
    @IBOutlet weak var cascadeSwitch: UISwitch!
    
    @IBOutlet weak var pin1Switch: UISwitch!
    @IBOutlet weak var pin2Switch: UISwitch!
    @IBOutlet weak var pin3Switch: UISwitch!
    @IBOutlet weak var pin4Switch: UISwitch!
    
    @IBOutlet weak var logMessageLabel: UILabel!
    @IBOutlet weak var plotView: PlotManager!
    
    var dataBox = DataBox()
    var recordPressed : Bool = false
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUI()
        BLEStack.shared.sensorDataUpdateDelegate = self
        BLEStack.shared.recordSensorDataDelegate = self
        BLEStack.shared.bluetoothLogDelegate = self
        BLEStack.shared.bluetoothStateChangeDelegate = self
        
        BLEStack.shared.mainVC = self
        plotView.initGraph()
        showRSSI()
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
            dataBox.labelTopRow()
            prepareStopRecordButton()
            recordPressed = true
        }
        // Stop Recording
        else
        {
            prepareRecordButton()
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
    
    @IBAction func pulsingSwitchPressed(_ sender: UISwitch)
    {
        if pulsingSwitch.isOn
        {
            BLEStack.shared.writeValue(data: "<PULSEON>")
            dataBox.clear()
            dataBox.labelTopRow()
            prepareStopRecordButton()
            recordPressed = true
        }
        else
        {
            BLEStack.shared.writeValue(data: "<PULSEOFF>")
            prepareRecordButton()
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
    
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
    
    
    @IBAction func pin3SwitchPressed(_ sender: UISwitch) {
        if pin3Switch.isOn
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN3ON>")
        }
        else
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN3OFF>")
        }
    }
    
    
    @IBAction func pin4SwitchPressed(_ sender: UISwitch) {
        if pin4Switch.isOn
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN4ON>")
        }
        else
        {
            BLEStack.shared.writeValue(data: "<CONTROLPIN4OFF>")
        }
    }
    
   
}

//MARK: UI Display Logic
extension MainVC
{
    
    func prepareConnectButton()
    {
        self.connectButton.layer.cornerRadius = 5.0
        self.connectButton.layer.backgroundColor = UIColor.systemIndigo.cgColor
        self.connectButton.tintColor = UIColor.white
    }
    
    // When Stop has been pressed : Back to original state and data saving should occur
    func prepareRecordButton()
    {
        self.recordButton.layer.cornerRadius = 5.0
        self.recordButton.layer.backgroundColor = UIColor.systemIndigo.cgColor
        self.recordButton.tintColor = UIColor.white
    }
    
    // When Record button has been pressed - record button turns red and sign changes
    func prepareStopRecordButton()
    {
        recordButton.setTitle("Stop", for: .normal)
        recordButton.layer.backgroundColor = UIColor.systemRed.cgColor
        
    }
    
    // UI
    func setUI()
    {
        self.pulsingSwitch.isOn = false
        self.cascadeSwitch.isOn = false
        self.pin1Switch.isOn = false
        self.pin2Switch.isOn = false
        self.pin3Switch.isOn = false
        self.pin4Switch.isOn = false
        
        prepareRecordButton()
        prepareConnectButton()
        
        self.logMessageLabel.text = "Ready"
    }
}

//MARK: Data Delegates
extension MainVC : SensorDataUpdateDelegate, RecordSensorDataDelegate, BluetoothLogDelegate, BluetoothStateChangeDelegate
{
    func updateSensorValue()
    {
        self.plotView.drawPlotU()
        self.plotView.drawPlotV()
        self.plotView.drawPlotW()
        self.plotView.drawPlotX()
        self.plotView.drawPlotY()
        self.plotView.drawPlotZ()
    }
    
    // whenever new data from BLEStack refreshed, append data
    func recordOnCondition()
    {
        if recordPressed == true
        {
            //print("append called")
            dataBox.append()
        }
    }
    
    func displayLogOnUI()
    {
        logMessageLabel.text = SingletonBlackboard.shared.log_message
    }
    
    func applyStateChanges()
    {
        if(SingletonBlackboard.shared.peripheral_state == "NMPD")
        {
            pulsingSwitch.isOn = false
            prepareRecordButton()
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
    /*  @brief Plots data in every designated interval (current: 0.3 seconds)
        @detail Instead of following the sensor's sampling frequency for plotting frequency,
                designate a specialized timer for this function
     */
    func showPlot()
    {
        // TODO: see if this function can be implemented in the background thread
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if BLEStack.shared.connectedFlag == true
            {
                self.updateSensorValue()
            }
        }
        
    }
    
    func showRSSI()
    {
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let myPeripheral = BLEStack.shared.peripheral
            {
                myPeripheral.readRSSI()
            }
        }
    }
    
}







