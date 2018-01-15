//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Adam Hogan on 7/13/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    

    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Date Created"
        
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
