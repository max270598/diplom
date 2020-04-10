//
//  BannersSubModuleProtocol.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/6/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import InfiniteScrolling


protocol BannersSubModuleBannerProtocol: InfiniteScollingData {
    var id: Int { get set }
    var title: String { get set }
    var subTitle: String { get set }
    var image: String { get set }
    var backgroundImage: String { get set }
    var productId: Int { get set }
}

struct BannersSubModuleBanner: BannersSubModuleBannerProtocol {
    
    
    
    var id: Int
    var title: String
    var subTitle: String
    var image: String
    var backgroundImage: String
    var productId: Int

    init(id: Int, title: String, subTitle: String, image: String, backgroundImage: String, productId: Int) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.backgroundImage = backgroundImage
        self.productId = productId
    }
}

//extension BannersSubModuleInputBanner: InfiniteScollingData {}
