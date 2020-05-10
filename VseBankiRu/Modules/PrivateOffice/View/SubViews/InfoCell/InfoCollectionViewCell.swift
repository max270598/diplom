//
//  InfoCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var aboutAppButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    
    
    var delegate: aboutHelpDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.aboutAppButton.clipsToBounds = true
        self.helpButton.clipsToBounds = true
        
        self.aboutAppButton.cornerRadius = self.aboutAppButton.frame.height / 2
        self.helpButton.cornerRadius = self.helpButton.frame.height / 2

        // Initialization code
    }
    @IBAction func aboutAppButtonTapped(_ sender: Any) {
        self.delegate?.showAboutApp()
    }
    @IBAction func helpButtonTapped(_ sender: Any) {
        self.delegate?.showHelp()
    }
    
}
