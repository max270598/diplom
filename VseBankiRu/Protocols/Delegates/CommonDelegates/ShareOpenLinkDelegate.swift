//
//  ShareLinkDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/22/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

protocol ShareOpenLinkDelegate: class {
    func shareLink(url: String, sender: UIView)
    func openCredit(url: String, sender: UIView)
}
