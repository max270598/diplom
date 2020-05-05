//
//  UIButton+Extension.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/6/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func inFavourite(_ itemId: String) {
        let inFavourite = CreditListFavouriteService.inFavorite(itemId)
        self.isSelected = inFavourite
    }

    func favourite(_ itemId: String) {
        self.isSelected.toggle()
        CreditListFavouriteService.inFavorite(itemId) ? CreditListFavouriteService.removeFavorite(itemId) : CreditListFavouriteService.addFavorite(itemId)
    }
}
