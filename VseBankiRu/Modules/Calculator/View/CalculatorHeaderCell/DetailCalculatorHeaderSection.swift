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
    
  
    @IBOutlet weak var creditAmountLabel: UILabel!
    
    @IBOutlet weak var overPaymentLabel: UILabel!
    
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var dateEndLabel: UILabel!
    
    @objc private var objectToObserve: CalculatorHeaderObserved?
    
    private var creditAmountObservation: NSKeyValueObservation?
    private var monthlyPaymentObservation: NSKeyValueObservation?
    private var overPaymentObservation: NSKeyValueObservation?
    private var dateEndObservation: NSKeyValueObservation?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func configure(observed model: CalculatorHeaderObserved) {
        
        self.objectToObserve = model
        
       
        
        // MARK: Calculator Model Observers
        
        self.creditAmountObservation = observe(
            \.objectToObserve?.creditAmount,
            options: [.new]
        ) { price, change in
            if let newValue = change.newValue, let newValueInt = newValue {
                self.creditAmountLabel.text = newValueInt.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
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
        
        self.overPaymentObservation = observe(
            \.objectToObserve?.overPayment,
            options: [.new]
        ) { price, change in
            if let newValue = change.newValue, let newValueDouble = newValue {
                self.overPaymentLabel.text = "\(newValueDouble.formattedWithSeparator)" + " " + CurrencySymbols.rubles.rawValue
            }
        }
        
        self.dateEndObservation = observe(\.objectToObserve?.dateEnd, options: .new) { price, change in
            if let newValue = change.newValue, let newValueDate = newValue {
                self.dateEndLabel.text = Formatter.dateFormatter(date: newValueDate)
            }
        }
        
    }
}

private extension DetailCalculatorHeaderSection {
    
    func commonInit() {
        
        self.backgroundColor = .clear
        
        self.contentView = UINib(nibName: "DetailCalculatorHeaderSection", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.addSubview(self.contentView)
        
        self.setupShadow()
    }
    
    func setupShadow() {
        
        shadowView.backgroundColor          = .clear
        shadowView.layer.shadowColor        = UIColor(red: 229.0/255.0, green: 233.0/255.0, blue: 237.0/255.0, alpha: 1.0).cgColor
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
