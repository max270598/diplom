//
//  CreditSkeletonCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/26/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditSkeletonCollectionViewCell: UICollectionViewCell {
    var shadowLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setShadow()
    }
    
}
