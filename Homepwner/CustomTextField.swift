//
//  CustomTextField.swift
//  Homepwner
//
//  Created by Adam Hogan on 7/12/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        layer.borderWidth = 0.0
        return true
    }
}
