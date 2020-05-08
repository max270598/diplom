//
//  AlphaCalculatorService.swift
//  Sberleasing
//
//  Created by Vonavi on 04.03.2020.
//  Copyright © 2020 Sberbank Leasing Frontend System. All rights reserved.
//

import Foundation

final class CreditCalculator {
    
    private var calcParams = CreditCalculatorParams()
    
    
    var monthlyPayment: Double {
        let a = self.calcParams.sum * (calcParams.ratePercent * pow(1 + self.calcParams.ratePercent , self.calcParams.time)) / (pow(1 + self.calcParams.ratePercent , self.calcParams.time) - 1)
        return a
    }
    
    var overPayment: Double {
        let a  = self.monthlyPayment * self.calcParams.time
        return a
    }
    var creditAmount: Double {
        let a = self.calcParams.sum + self.overPayment
        return a
    }
    
    var endDate: Date {
        let components = Calendar.current.date(byAdding: .month, value: 2, to: self.calcParams.startDate)!
//        let calendar = Calendar(identifier: .iso8601)
//        let date = calendar.date(from: components)
       return components
    }
    
    
    // MARK: DEV
    
    
    func set(params calcParams: CreditCalculatorParams) {
        self.calcParams = calcParams
    }
}

private extension CreditCalculator {
    
    
    
}
//print(Int(round(test.payment)))
//print(Int(round(test.leasing)))
//print(test.appreciation)
