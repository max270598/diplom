//
//  UICollectionCell+Extension.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/22/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    // MARK: Outer Cell Shadow
    
    // TODO: Сделать Inspectable
    
    func setShadow() {
        // Set Border Radius
        self.contentView.layer.cornerRadius     = 8
        self.contentView.layer.masksToBounds    = true
        // Set Shadow
        self.layer.backgroundColor  = UIColor.clear.cgColor
        self.layer.shadowColor      = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.9294117647, alpha: 1).cgColor
        self.layer.shadowOffset     = CGSize(width: 0.0, height: 5.0)
        self.layer.shadowRadius     = 10.0
        self.layer.shadowOpacity    = 1.0
        self.layer.masksToBounds    = false
    }
    
    // MARK: Active Cell Transform
    
    func transformCell(_ active: Bool) {
        switch active {
        case true:
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        default:
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}

