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

final class DetailCalculatorHeaderObserved: NSObject, CalculatorHeaderModelType {
   
    
    
    
    @objc private(set) dynamic var creditAmount: Int = 0
    @objc private(set) dynamic var overPayment: Int = 0
    @objc private(set) dynamic var dateEnd: Date = Date(timeIntervalSinceNow: .zero)
    @objc private(set) dynamic var monthlyPayment: Int  = 0

    
    @objc private(set) dynamic var leaseAmount: Int     = 0
    @objc private(set) dynamic var annualRise: Double   = 0
    
    private lazy var calculatorService  = CreditCalculator()
    private(set) var calculatorParams   = CreditCalculatorParams()
    
    func update(type: CalculatorSliderType, newValue: Double) {
        
        switch type {
        case .advance:
            self.calculatorParams.advancePercent        = newValue
        case .term:
            self.calculatorParams.month                 = newValue
        case .lastPayment:
            self.calculatorParams.lastPaymentPercent    = newValue
        default: break
        }
        
        self.update()
    }
    
    func set(params: AutoMallItemDetailCalcParams) {
        self.calculatorParams.advancePercent    = Double(params.minAdvice)
        self.calculatorParams.month             = Double(params.maxMonth)
    }
    
    func set(price: Double) {
        self.calculatorService.changePrice(price: price)
        self.update()
    }
    
    // TODO: Устанавливать значения сразу после инициализации
    private func update() {
        self.calculatorService.set(params: self.calculatorParams)
        self.leaseAmount    = Int(round(calculatorService.leasing))
        self.monthlyPayment = Int(round(calculatorService.payment))
        self.annualRise     = calculatorService.appreciation
    }
}
