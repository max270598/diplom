//
//  UITableViewCell+Extension.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

// MARK: Set clear BG Color for selected state
extension UITableViewCell {
    
    func changeSelectedBG(_ color: UIColor? = R.color.selectedCell()) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = color
        self.selectedBackgroundView = bgColorView
    }
}
