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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var arrangeButton: UIButton!
    
    var creditURL: String = ""
    
    var delegate: CreditsListCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        self.alpha = 0
        // Initialization code
    }

    
    @IBAction func arrangeButtonTapped(_ sender: Any) {
        self.delegate?.openCredit(url: self.creditURL, sender: self)
    }
}

extension CreditsPromoCollectionViewCell {
    
    
    func configure(with model: BannersSubModuleBannerProtocol) {
        
        self.rateLabel.text = model.min_rate
        self.sumLabel.text = model.short_sum
        self.timeLabel.text = model.max_time
        
        if let photoUrl = URL(string: model.bank_logo_url) {
            self.bankLogoImageView.kf.indicatorType = .activity
            self.bankLogoImageView.kf.setImage(with: photoUrl)
        }
        
        self.creditURL = model.credit_url
        
//        if let backPhotoUrl = URL(string: model.background_image) {
//            self.backImageView.kf.indicatorType = .activity
//            self.backImageView.kf.setImage(with: backPhotoUrl)
//        }
        
        self.alpha = 1
    }
    
//    func hideAllViews() {
//        viewsArray.forEach {$0.alpha = 0}
//    }
//
//    func showAllViews() {
//                    self.viewsArray.forEach {$0.alpha = 1}
//
//    }
}
