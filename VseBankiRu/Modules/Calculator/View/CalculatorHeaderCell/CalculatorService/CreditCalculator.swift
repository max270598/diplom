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
        let c = self.calcParams.ratePercent / 12 / 100
        let b = pow(1 + c, self.calcParams.time)
        guard b != 1 else {return 0}
        let a = self.calcParams.sum * ((c * b) / (b - 1))
        print("c", c , "b", b, "a", a)
        return a
    }
    
    var overPayment: Double {
        let a =  self.creditAmount - self.calcParams.sum
        return a
    }
    var creditAmount: Double {
         let a  = self.monthlyPayment * self.calcParams.time
        guard a != 0 else {return self.calcParams.sum}
        return a
    }
    
    var endDate: Date {
        let components = Calendar.current.date(byAdding: .month, value: Int(self.calcParams.time), to: self.calcParams.startDate)!
//        let calendar = Calendar(identifier: .iso8601)
//        let date = calendar.date(from: components)
       return components
    }
    
    
    // MARK: DEV
    
    
    func set(params calcParams: CreditCalculatorParams) {
        self.calcParams = calcParams
        print(calcParams)
    }
}

private extension CreditCalculator {
    
    
    
}
//print(Int(round(test.payment)))
//print(Int(round(test.leasing)))
//print(test.appreciation)
