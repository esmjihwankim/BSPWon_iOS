//
//  SettingsVC.swift
//  BSPWon
//
//  Created by skkuwon on 2021/07/04.
//

import UIKit


class SettingsVC : UIViewController
{

    @IBOutlet weak var topBannerButton: UIButton!
    @IBOutlet weak var yMaxTextField: UITextField!
    @IBOutlet weak var yMinTextField: UITextField!
    @IBOutlet weak var incrementTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    
    var plotManager : PlotManager?
    
    override func viewDidLoad()
    {
        setUI()
    }
    
    func setUI()
    {
        self.topBannerButton.layer.backgroundColor = UIColor.black.cgColor
        self.topBannerButton.layer.cornerRadius = 10.0
        self.applyButton.layer.cornerRadius = 5.0
        self.applyButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.applyButton.tintColor = UIColor.white
        yMaxTextField.keyboardType = UIKeyboardType.numberPad
        yMinTextField.keyboardType = UIKeyboardType.numberPad
        incrementTextField.keyboardType = UIKeyboardType.numberPad
    }
    
    
    @IBAction func topBannerPressed(_ sender: UIButton) {
        let thisURL = URL(string: "https://www.skkuwongroup.online")!
        if UIApplication.shared.canOpenURL(thisURL){
            UIApplication.shared.open(thisURL, options: [:], completionHandler: nil)
        }
    }
    
    
    // Apply setting to graph view
    @IBAction func applyButtonPressed(_ sender: UIButton)
    {
        print("pressed apply")
    }
    
}


extension SettingsVC : UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
