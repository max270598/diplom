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
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil {
                 shadowLayer = CAShapeLayer()
                 shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
                 shadowLayer.fillColor = UIColor.white.cgColor
            self.contentView.layer.masksToBounds = true
                 shadowLayer.shadowColor = UIColor.darkGray.cgColor
                 shadowLayer.shadowPath = shadowLayer.path
                 shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                 shadowLayer.shadowOpacity = 0.6
                 shadowLayer.shadowRadius = 3
            self.layer.masksToBounds = false
                 layer.insertSublayer(shadowLayer, at: 0)
                 //layer.insertSublayer(shadowLayer, below: nil) // also works
             }    }
    
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

