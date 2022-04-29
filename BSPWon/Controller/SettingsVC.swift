//
//  SettingsVC.swift
//  BSPWon
//
//  Created by skkuwon on 2022/04/15.
//

import UIKit

class SettingsVC : UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource
{
    let pickerView = ToolbarPickerView()
    let projects = ["Neuromorphic", "Jellyfish", "Pressure Array"]

    @IBOutlet weak var projectChoiceButton: UIButton!

    override func viewDidLoad()
    {
        projectChoiceButton.layer.cornerRadius = 10
    }

    @IBAction func showPickerviewButton(_ sender: Any)
    {
        createPickerView()
    }
    
}


extension SettingsVC
{
    func createPickerView()
    {
        pickerView.delegate = self
        pickerView.center = self.view.center
        self.view.addSubview(pickerView)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return projects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return projects[row]
    }
}

extension SettingsVC : ToolbarPickerViewDelegate
{
    func didTapDone()
    {
        
    }
    
    func didTapCancel()
    {
        self.pickerView.resignFirstResponder()
    }
    
}
