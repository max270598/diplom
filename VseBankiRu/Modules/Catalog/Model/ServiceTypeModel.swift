//
//  BanksCatalogModel.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import UIKit

struct ServiceTypeModel {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.image = image
        self.name = name
    }
    
}
