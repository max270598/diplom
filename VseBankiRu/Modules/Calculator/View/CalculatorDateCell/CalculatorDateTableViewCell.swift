//
//  CalculatorDateTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CalculatorDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    
    var delegate: CalculatorDateDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupDatePicker()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CalculatorDateTableViewCell {
    func configure(date: Date) {
        self.dateTextField.text = Formatter.dateFormatter(date: date)
    }
    
    
}

private extension CalculatorDateTableViewCell {
    func setupDatePicker() {
        
        let localeID = Locale.preferredLanguages.first //Язык для datePicker или в info.Plist
        self.datePicker.locale = Locale(identifier: localeID!)
        self.dateTextField.inputView = self.datePicker
        self.datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        
        self.datePicker.addTarget(self, action: #selector(getDateFromPicker), for: .valueChanged)
    }
    
    @objc func doneAction() {
        self.dateTextField.endEditing(true)
    }
    
    @objc func getDateFromPicker() {
        self.dateTextField.text = Formatter.dateFormatter(date: self.datePicker.date)
        self.delegate?.startDateDidChange(startDate: self.datePicker.date)
    }
}
