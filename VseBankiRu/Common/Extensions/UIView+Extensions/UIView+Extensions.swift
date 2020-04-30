//
//  UIView+Extensions.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit
// MARK: Change Ratio Constraint
extension UIView {
    
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}

@IBDesignable extension UIView {

    class func colored(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }

    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }

//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.15
//        layer.shadowOffset = CGSize(width: 0, height: 3)
//        layer.shadowRadius = 4
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    
//    func addShadowCorner(cornerRadius: CGFloat, backgoundColor: UIColor = UIColor.white, shadowColor: CGColor = UIColor.black.cgColor,
//    shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
//    shadowOpacity: Float = 0.4,
//    shadowRadius: CGFloat = 3.0 ) {
//
//       let shadowLayer = CAShapeLayer()
//
//          shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//          shadowLayer.fillColor = backgoundColor.cgColor
////        contentView.layer.masksToBounds = true
//          shadowLayer.shadowColor = shadowColor
//          shadowLayer.shadowPath = shadowLayer.path
//          shadowLayer.shadowOffset = shadowOffset
//          shadowLayer.shadowOpacity = shadowOpacity
//          shadowLayer.shadowRadius = shadowRadius
//        layer.masksToBounds = false
//          layer.insertSublayer(shadowLayer, at: 0)
//    }
    
    
    func addShadowCorner(cornerRadius: CGFloat, offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

