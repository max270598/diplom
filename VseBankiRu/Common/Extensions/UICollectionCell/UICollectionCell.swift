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
    
    func setShadow(cornerRadius: CGFloat, backgroundColor: UIColor, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        // Set Border Radius
        var shadowLayer: CAShapeLayer!
        if shadowLayer == nil {
            
                 shadowLayer = CAShapeLayer()
                 shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath //12
                 shadowLayer.fillColor = backgroundColor.cgColor //whire
            self.contentView.layer.masksToBounds = true
                 shadowLayer.shadowColor = shadowColor.cgColor //darkgrey
                 shadowLayer.shadowPath = shadowLayer.path
                 shadowLayer.shadowOffset = shadowOffset // 2.0 2.0
                 shadowLayer.shadowOpacity = shadowOpacity //0.6
                 shadowLayer.shadowRadius = shadowRadius // 3
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

