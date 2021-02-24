//
//  ViewController.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/01/22.
//

import UIKit

class MainVC: UIViewController
{
    
    @IBOutlet weak var xValueLabel: UILabel!
    @IBOutlet weak var yValueLabel: UILabel!
    @IBOutlet weak var zValueLabel: UILabel!
    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var dataBox = DataBox()
    var recordPressed : Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        BLEStack.shared.sensorDataUpdateDelegate = self
    }
    
    @IBAction func recordButtonPressed(_ sender: UIButton)
    {
        // Start Recording
        if(recordPressed == false)
        {
            recordPressed = true
            recordButton.setTitle("Stop", for: .normal)
        }
        // Stop Recording
        else
        {
            recordPressed = false
            recordButton.setTitle("Record", for: .normal)
        }
    }
}

extension MainVC : SensorDataUpdateDelegate
{
    func updateLabel()
    {
        xValueLabel.text = String(SingletonBlackboard.shared.data.dataX)
        yValueLabel.text = String(SingletonBlackboard.shared.data.dataY)
        zValueLabel.text = String(SingletonBlackboard.shared.data.dataZ)
    }
}




