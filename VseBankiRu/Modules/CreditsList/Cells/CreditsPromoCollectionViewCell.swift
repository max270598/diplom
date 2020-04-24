//
//  CreditsPromoCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 3/30/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit
import Kingfisher

class CreditsPromoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var bankLogoImageView: UIImageView!
    @IBOutlet weak var timeStackView: UIStackView!
    @IBOutlet weak var rateStackView: UIStackView!
    @IBOutlet weak var sumView: UIView!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cellViewsArray = [bankLogoImageView, sumView, timeStackView, rateStackView]
        cellViewsArray.forEach { [weak self] (item) in
            self?.setupUI(view: item!)
        }
        // Initialization code
    }

    override func layoutSubviews() {
                sumView.frame.size = CGSize(width: self.sumLabel.frame.width + 10, height: self.sumLabel.frame.height + 10)
        print("lay")

    }
}

extension CreditsPromoCollectionViewCell {
    func setupUI(view: UIView) {
        view.clipsToBounds = true
        view.cornerRadius = 8
        view.backgroundColor = UIColor.systemIndigo
    }
}
