//
//  ButtonTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/5/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    var url: String = ""
    var delegate: CreditsListDetailDelegate?
    @IBOutlet weak var arrangeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.arrangeButton.clipsToBounds = true
        self.arrangeButton.cornerRadius = self.arrangeButton.frame.height / 2
        // Initialization code
    }

    @IBAction func arrangeButtonTapped(_ sender: Any) {
        self.delegate?.openCredit(url: self.url, sender: self)
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(url: String) {
        self.url = url
    }
    
}
