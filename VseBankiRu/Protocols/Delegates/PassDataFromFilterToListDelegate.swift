//
//  PassDataFromFilterDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/1/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol PassDataFromFilterToListDelegate: class {
    func setFilterdData(filteredCredits: [CreditModel], filterItem: FilterItemModel)
}
