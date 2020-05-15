//
//  CatalogPartnersCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/14/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CatalogPartnersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bankIdLabel: UILabel!
    @IBOutlet weak var bankNameLable: UILabel!
    @IBOutlet weak var bankLogoImageView: UIImageView!
    var shadowLayer = CAShapeLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
//        self.backView.addShadowCorner(cornerRadius: 10, offset: CGSize(width: 0, height: 0), color: .black, radius: 10, opacity: 0.6)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setShadow(cornerRadius: 12, backgroundColor: .white, shadowColor: .darkGray, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.2, shadowRadius: 5)
    }

}


extension CatalogPartnersCollectionViewCell {
    func configure(bankLogoUrl: String, bankName: String, bankId: String) {
        

        print("CONFIGURE", bankLogoUrl, bankName, bankId)
        self.bankNameLable.text = bankName
        self.bankIdLabel.text = bankId
        
        if let photoUrl = URL(string: bankLogoUrl) {
            self.bankLogoImageView.kf.indicatorType = .activity
            self.bankLogoImageView.kf.setImage(with: photoUrl)
        }
        
    }
}
