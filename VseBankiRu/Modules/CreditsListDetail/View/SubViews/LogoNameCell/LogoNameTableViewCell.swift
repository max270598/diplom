//
//  LogoNameTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/3/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class LogoNameTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: CreditModel) {
        self.titleLabel.text = model.bank_name
        self.subTitleLabel.text = model.bank_id
        
        if let logoUrl = URL(string: model.bank_logo_url) {
            self.logoImageView.kf.indicatorType = .activity
            self.logoImageView.kf.setImage(with: logoUrl)
        }
    }
    
}
