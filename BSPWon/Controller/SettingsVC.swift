//
//  SettingsVC.swift
//  BSPWon
//
//  Created by skkuwon on 2021/07/04.
//

import UIKit


class SettingVC : UIViewController
{
    
    @IBOutlet weak var topBannerView: UIView!
    @IBOutlet weak var yMaxTextField: UITextField!
    @IBOutlet weak var yMinTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    
    override func viewDidLoad()
    {
        setUI()
    }
    
    func setUI()
    {
        self.topBannerView.layer.cornerRadius = 10.0
        self.topBannerView.layer.backgroundColor = UIColor.black.cgColor
        self.applyButton.layer.cornerRadius = 5.0
        self.applyButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.applyButton.tintColor = UIColor.white
        yMaxTextField.keyboardType = UIKeyboardType.numberPad
        yMinTextField.keyboardType = UIKeyboardType.numberPad
    }
    
}

extension SettingVC : UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
