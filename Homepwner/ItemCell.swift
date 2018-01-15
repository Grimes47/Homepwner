//
//  ItemCell.swift
//  Homepwner
//
//  Created by Adam Hogan on 7/10/17.
//  Copyright © 2017 Adam Hogan. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
   
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}


