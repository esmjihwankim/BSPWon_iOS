//
//  SettingsVC.swift
//  BSPWon
//
//  Created by skkuwon on 2022/04/15.
//

import UIKit

class SettingsVC : UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var projectChoiceButton: UIButton!
    
    
 
    override func viewDidLoad()
    {
        projectChoiceButton.layer.cornerRadius = 10
    }
    
    let projects = ["Neuromorphic", "Jellyfish", "Pressure Array"]
    
    
    @IBAction func showPickerviewButton(_ sender: Any) {
    
    
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return projects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
}
