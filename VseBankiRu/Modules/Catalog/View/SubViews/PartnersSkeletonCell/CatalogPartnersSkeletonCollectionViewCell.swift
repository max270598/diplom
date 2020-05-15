//
//  CatalogPartnersSkeletonCollectionViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/15/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CatalogPartnersSkeletonCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
         self.setShadow(cornerRadius: 12, backgroundColor: .white, shadowColor: .darkGray, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.2, shadowRadius: 5)
    }

}
