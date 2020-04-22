//
//  ShareLinkDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/22/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

protocol CreditsListCellDelegate: class {
    func shareLink(url: String, sender: UIView)
}
