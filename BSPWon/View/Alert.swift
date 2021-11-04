//
//  Bluetooth.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/12.
//

import UIKit

class AlertCall {
    
    static func showAlert(viewController : UIViewController?, title : String? = "Hang on!",
                          message: String, buttonTitle: String? = "Okay", handler : ((UIAlertAction) -> ())?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default)
        alertController.addAction(okAction)
        
        if let safeViewController = viewController
        {
            safeViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

