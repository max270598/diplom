//
//  CollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/25/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit




class CreditsPromoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var bankLogoImageView: UIImageView!
    @IBOutlet weak var rateView: TwoGradientView!
    @IBOutlet weak var timeView: TwoGradientView!
    @IBOutlet weak var sumView: TwoGradientView!
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    var viewsArray: [UIView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewsArray = [self.sumView, self.rateView, self.timeView, self.bankLogoImageView]
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cornerView(views: self.viewsArray)
        
    }
}

extension CreditsPromoCollectionViewCell {
    func cornerView(views: [UIView]) {
        views.forEach { (view) in
            view.clipsToBounds = true
            view.cornerRadius = 8
        }
    }
}
