//
//  CreditsListFilterCellDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol AutoMallFilterItemCellDelegate: class {
    
    func removeItem(id paramId: String)
}

//extension AutoMallFilterPresenter: AutoMallFilterItemCellDelegate {
//    
//    func removeItem(id paramId: String) {
//        self.interactor.updateFilterParams(with: [paramId: ""])
//    }
//}
