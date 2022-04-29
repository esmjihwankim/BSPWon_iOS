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
    
    @IBOutlet weak var pulsingMessageLabel: UILabel!
    @IBOutlet weak var plotView: PlotManager!
    
    var automaticPulsing = AutomaticPulsing()
    var dataBox = DataBox()
    var recordPressed : Bool = false
    
    static let pulse_ui_notification = Notification.Name("signal_pulsing")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUI()
        BLEStack.shared.sensorDataUpdateDelegate = self
        BLEStack.shared.recordSensorDataDelegate = self
        BLEStack.shared.mainVC = self
        plotView.initGraph()
        NotificationCenter.default.addObserver(self, selector: #selector(on_pulse_notification), name: MainVC.pulse_ui_notification, object: nil)
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
            recordButton.layer.backgroundColor = UIColor.systemIndigo.cgColor
            dataBox.saveToFileSystem()
            dataBox.clear()
        }
    }
    
    //MARK: Switches GPIO Control
    @IBAction func pulsingSwitchPressed(_ sender: UISwitch)
    {
        if pulsingSwitch.isOn
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEON>")
            dataBox.clear()
            prepareStopRecordButton()
            
            // automatic pulsing instance activated
            automaticPulsing.start_pulsing()
        }
        else
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEOFF>")
            prepareOriginalRecordButton()
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

extension MainVC
{
    
    func prepareOriginalConnectButton()
    {
        self.connectButton.layer.cornerRadius = 5.0
        self.connectButton.layer.backgroundColor = UIColor.systemIndigo.cgColor
        self.connectButton.tintColor = UIColor.white
    }
    
    func prepareOriginalRecordButton()
    {
        self.recordButton.layer.cornerRadius = 5.0
        self.recordButton.layer.backgroundColor = UIColor.systemIndigo.cgColor
        self.recordButton.tintColor = UIColor.white
    }
    
    func prepareStopRecordButton()
    {
        recordPressed = true
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
        
        prepareOriginalRecordButton()
        prepareOriginalConnectButton()
        
        self.pulsingMessageLabel.text = "Ready"
    }
    
    // Pulsing UI change from Notification
    @objc
    func on_pulse_notification()
    {
        if (Pulse_State.addup_state)
        {
            self.pulsingMessageLabel.text = "Stay still!"
        }
        else if (Pulse_State.sign_state)
        {
            self.pulsingMessageLabel.text = "Perform gesture"
        }
        else if (Pulse_State.off_state)
        {
            self.pulsingMessageLabel.text = "Ready"
            
        }
    }
}

//MARK: Delegate Pattern for Updating value to UI
extension MainVC : SensorDataUpdateDelegate
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






