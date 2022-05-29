//
//  SettingsVC.swift
//  BSPWon
//
//  Created by skkuwon on 2021/07/04.
//

import UIKit


class PinNamesVC : UIViewController
{

    @IBOutlet weak var topBannerButton: UIButton!
    
    var plotManager : PlotManager?
    
    override func viewDidLoad()
    
    {
        setUI()
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
}


extension PinNamesVC : UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

