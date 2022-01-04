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
    
    var plotManager : PlotManager?
    
    override func viewDidLoad()
    {
        setUI()e
    }
    
    func setUI()
    {
        self.topBannerButton.layer.backgroundColor = UIColor.black.cgColor
        self.topBannerButton.layer.cornerRadius = 10.0
    }
    
    
    @IBAction func topBannerPressed(_ sender: UIButton)
    {
        let thisURL = URL(string: "https://www.skkuwongroup.online")!
        if UIApplication.shared.canOpenURL(thisURL)
        {
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
