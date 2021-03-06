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
    var id: String { get set }
    var background_image: String { get set }
    var title: String {get set}
    var credit_url:String {get set}
    var bank_logo_url: String { get set }
    var short_sum: String { get set }
    var min_rate: String? { get set }
    var max_time: String { get set }
    
}

    struct BannersSubModuleBanner: BannersSubModuleBannerProtocol {
        var id: String
        var background_image: String
        var bank_logo_url: String
        var title: String
        var credit_url: String
        var short_sum: String
        var min_rate: String?
        var max_time: String
        
        init(id: String, background_image: String, bank_logo_url: String, title: String, credit_url: String, short_sum: String, min_rate: String?, max_time: String ) {
        self.id = id
        self.background_image = background_image
        self.bank_logo_url = bank_logo_url
        self.title = title
        self.credit_url = credit_url
        self.short_sum = short_sum
        self.min_rate = min_rate
        self.max_time = max_time
    }
}

//extension BannersSubModuleInputBanner: InfiniteScollingData {}
