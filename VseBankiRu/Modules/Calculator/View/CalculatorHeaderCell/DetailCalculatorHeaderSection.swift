//
//  DetailCalculatorHeaderSection.swift
//  Sberleasing
//
//  Created by Stanislav Ivanov on 19.02.2020.
//  Copyright © 2020 Sberbank Leasing Frontend System. All rights reserved.
//

import UIKit

final class DetailCalculatorHeaderSection: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var cornerRadiusView: UIView!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    // FIXME: Исправить шрифт
    
  
    
    @IBOutlet private weak var carPriceLabel: UILabel!
    @IBOutlet private weak var leaseAmountLabel: UILabel!
    @IBOutlet private weak var monthlyPaymentLabel: UILabel!
    @IBOutlet private weak var annualRiseLabel: UILabel!
    
    @objc private var objectToObserve: DetailCalculatorHeaderObserved?
    
    private var leaseAmountObservation: NSKeyValueObservation?
    private var monthlyPaymentObservation: NSKeyValueObservation?
    private var annualRiseObservation: NSKeyValueObservation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func configure(price: Int?,
                   oldPrice: Int?,
                   calcParams: AutoMallItemDetailCalcParams?,
                   observed model: DetailCalculatorHeaderObserved
    ) {
        
        self.objectToObserve = model
        
        if let price = price {
            self.carPriceLabel.text = price.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
        }
        
        if let oldPrice = oldPrice, oldPrice > 0 {
            let oldCarPriceString = oldPrice.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldCarPriceString)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            self.oldCarPriceLabel.attributedText = attributeString
            self.oldCarPriceLabel.isHidden = false
            self.heightConstraint.constant = 138
        }
        
        // MARK: Calculator Model Observers
        
        self.leaseAmountObservation = observe(
            \.objectToObserve?.leaseAmount,
            options: [.new]
        ) { price, change in
            if let newValue = change.newValue, let newValueInt = newValue {
                self.leaseAmountLabel.text = newValueInt.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
            }
        }
        
        self.monthlyPaymentObservation = observe(
            \.objectToObserve?.monthlyPayment,
            options: [.new]
        ) { price, change in
            if let newValue = change.newValue, let newValueInt = newValue {
                self.monthlyPaymentLabel.text = newValueInt.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
            }
        }
        
        self.annualRiseObservation = observe(
            \.objectToObserve?.annualRise,
            options: [.new]
        ) { price, change in
            if let newValue = change.newValue, let newValueDouble = newValue {
                self.annualRiseLabel.text = "\(newValueDouble.formattedWithSeparator)" + " " + "%"
            }
        }
        
        if let calcParams = calcParams {
            self.objectToObserve?.set(params: calcParams)
        }
        
        if let price = price {
            self.objectToObserve?.set(price: Double(price))
        }
    }
}

private extension DetailCalculatorHeaderSection {
    
    func commonInit() {
        
        self.backgroundColor = .clear
        
        self.contentView = .firstView(owner: self)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.addSubview(self.contentView)
        
        self.setupShadow()
    }
    
    func setupShadow() {
        
        shadowView.backgroundColor          = .clear
        shadowView.layer.shadowColor        = UIColor(dRed: 229, dGreen: 233, dBlue: 237, alpha: 1).cgColor
        shadowView.layer.shadowOffset       = CGSize(width: 5, height: 5)
        shadowView.layer.shadowOpacity      = 0.25
        shadowView.layer.shadowRadius       = 8
        shadowView.layer.masksToBounds      = false
        self.shadowView.layer.borderWidth   = 0
        
        cornerRadiusView.backgroundColor        = .white
        cornerRadiusView.layer.cornerRadius     = 8
        cornerRadiusView.clipsToBounds = true
        self.cornerRadiusView.layer.borderWidth = 0
    }
}
