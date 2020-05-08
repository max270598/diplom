//
//  CreditsListFilterDrawerViewControllerDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/29/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol CreditsListFilterDrawerDelegate {
    func updateFilterParametrs(filterItem: FilterItemModel)
}

protocol CreditsListFilterSwitchCellDelegate {
    func switchChanged(parametr: String, statemant: Bool)

}

protocol CreditsListFilterItemCellDelegate: class {

    func removeItem(row: Int)

}


