//
//  LeasingCalculatorParams.swift
//  Sberleasing
//
//  Created by Stanislav on 04.03.2020.
//  Copyright © 2020 Sberbank Leasing Frontend System. All rights reserved.
//

import Foundation

struct CreditCalculatorParams {
    //id: 1,
    //label: 'Легковой',
    var sum: Double          = 5000000
    var ratePercent: Double      = 7.5
    var time: Double  = 24
    var startDate: Date = Date(timeIntervalSinceNow: .zero)
    
}
