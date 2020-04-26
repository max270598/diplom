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
        self.hideAllViews()
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
    
    func configure(with model: BannersSubModuleBannerProtocol) {
        
        self.rateLabel.text = model.min_rate
        self.sumLabel.text = model.short_sum
        self.timeLabel.text = model.max_time
        
        if let photoUrl = URL(string: model.bank_logo_url) {
            self.bankLogoImageView.kf.indicatorType = .activity
            self.bankLogoImageView.kf.setImage(with: photoUrl)
        }
        
        if let backPhotoUrl = URL(string: model.background_image) {
            self.backImageView.kf.indicatorType = .activity
            self.backImageView.kf.setImage(with: backPhotoUrl)
        }
        
        self.showAllViews()
    }
    
    func hideAllViews() {
        viewsArray.forEach {$0.alpha = 0}
    }
    
    func showAllViews() {
                    self.viewsArray.forEach {$0.alpha = 1}
        
    }
}
