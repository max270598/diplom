//
//  CreditsListFilterDrawerCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/29/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListFilterDrawerCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if self.accessoryType == .checkmark {
            
        }
        // Configure the view for the selected state
    }
    
    
    
}
