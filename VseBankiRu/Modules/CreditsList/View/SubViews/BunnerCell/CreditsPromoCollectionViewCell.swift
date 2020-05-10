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
   
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var faceNumberLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var arrangeButton: UIButton!
    
    @IBOutlet weak var creditView: UIView!
    
    weak var delegate: ShareOpenLinkDelegate?
    
    var creditURL: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.arrangeButton.clipsToBounds = true
        self.arrangeButton.layer.cornerRadius = 8
        
        self.creditView.clipsToBounds = true
        self.creditView.layer.cornerRadius = 10
        self.hideAllViews()
        // Initialization code
    }

    @IBAction func arrangeButtonTapped(_ sender: Any) {
        guard let url = self.creditURL else {
            return
        }
        self.delegate?.openCredit(url: url, sender: self)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension CreditsPromoCollectionViewCell {
    func cornerView(views: [UIView]) {
        views.forEach { (view) in
            view.clipsToBounds = true
            view.cornerRadius = 8
        }
    }
    
    func configure(with model: CreditModel) {
        self.creditURL = model.credit_url
        self.faceNumberLabel.text = model.bank_id
        self.typeLabel.text = model.type
        self.rateLabel.text = String(model.min_rate!) + "%"
        self.sumLabel.text = model.short_sum
        self.timeLabel.text = model.short_time
        
        if let photoUrl = URL(string: model.bank_logo_url) {
            self.bankLogoImageView.kf.indicatorType = .activity
            self.bankLogoImageView.kf.setImage(with: photoUrl)
        }
        
//        if let backPhotoUrl = URL(string: model.background_image) {
//            self.backImageView.kf.indicatorType = .activity
//            self.backImageView.kf.setImage(with: backPhotoUrl)
//        }
        
        self.showAllViews()
    }
    
    func hideAllViews() {
        self.creditView.alpha = 0
    }
    
    func showAllViews() {
        self.creditView.alpha = 1
        
    }
}
