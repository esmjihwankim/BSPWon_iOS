//
//  ToolbarPickerView.swift
//  BSPWon
//
//  Created by skkuwon on 2022/04/24.
//

import Foundation
import UIKit


protocol ToolbarPickerViewDelegate : AnyObject {
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView
{
    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit()
    {
        let myToolBar = UIToolbar()
        myToolBar.barStyle = UIBarStyle.default
        myToolBar.isTranslucent = true
        myToolBar.tintColor = .black
        myToolBar.sizeToFit()
        
        let chooseButton = UIBarButtonItem(title: "Choose", style: .done, target: self, action: #selector(self.doneTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))
        myToolBar.setItems([chooseButton, cancelButton], animated: true)
        myToolBar.isUserInteractionEnabled = true
        
        self.toolbar = myToolBar
    
    }
    
    @objc func doneTapped()
    {
        self.toolbarDelegate?.didTapDone()
    }
    
    @objc func cancelTapped()
    {
        self.toolbarDelegate?.didTapCancel()
    }
    
}
