//
//  SegmentControllTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class SegmentControllTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSegmentControll() {
        self.segmentControll.numberOfSegments = 4
        
    }
    
}
