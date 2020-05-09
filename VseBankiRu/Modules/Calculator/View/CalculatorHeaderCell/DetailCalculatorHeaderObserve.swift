//
//  DetailCalculatorHeaderObserve.swift
//  Sberleasing
//
//  Created by Stanislav on 28.02.2020.
//  Copyright © 2020 Sberbank Leasing Frontend System. All rights reserved.
//

import Foundation

protocol CalculatorHeaderModelType: NSObjectProtocol {
    var creditAmount: Int { get }
    var monthlyPayment: Int { get }
    var overPayment: Int { get }
    var dateEnd: Date { get }
}

final class CalculatorHeaderObserved: NSObject, CalculatorHeaderModelType {
   
    
    
    
    @objc private(set) dynamic var creditAmount: Int = 0
    @objc private(set) dynamic var overPayment: Int = 0
    @objc private(set) dynamic var dateEnd: Date = Date(timeIntervalSinceNow: .zero)
    @objc private(set) dynamic var monthlyPayment: Int  = 0

    
    private lazy var calculatorService  = CreditCalculator()
    private(set) var calculatorParams   = CreditCalculatorParams()
    
    func update(type: SliderType, newValue: Double, date: Date) {
        
        switch type {
        case .sumSilder:
            self.calculatorParams.sum        = newValue
        case .rateSlider:
            self.calculatorParams.ratePercent                 = newValue
        case .timeSlider:
            self.calculatorParams.time    = newValue
        default: break
        }
        self.calculatorParams.startDate = date
        self.update()
    }
    
    
    // TODO: Устанавливать значения сразу после инициализации
    private func update() {
        self.calculatorService.set(params: self.calculatorParams)
        self.creditAmount    = Int(round(calculatorService.creditAmount))
        self.monthlyPayment = Int(round(calculatorService.monthlyPayment))
        self.overPayment     = Int(round(calculatorService.overPayment))
        self.dateEnd = calculatorService.endDate
    }
}
