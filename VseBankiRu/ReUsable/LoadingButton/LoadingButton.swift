//
//  LoadingButton.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

final class LoadingButton: UIButton {
    
    private var originalButtonText: String?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.activityColor
        return activityIndicator
    }()
    
    @IBInspectable var activityColor: UIColor = .white
    
    func showLoading() {
        self.isEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        self.showSpinning()
    }
    
    func hideLoading() {
        self.isEnabled = true
        self.setTitle(originalButtonText, for: .normal)
        self.activityIndicator.stopAnimating()
    }
}

private extension LoadingButton {
        
    func showSpinning() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
