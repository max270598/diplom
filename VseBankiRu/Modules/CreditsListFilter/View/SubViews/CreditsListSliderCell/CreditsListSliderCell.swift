//
//  CreditsListSliderCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import UIKit

class CreditsListSliderCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var minValueLabel: UILabel!
   
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var upperValueTextField: UITextField!
    
    /// Таймер чтобы запросы не улетали сразу
       private var timer: Timer?
//     private weak var delegate: CreditsListFilterDrawerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        self.upperValueTextField.delegate = self
        
        // Initialization code
    }
    @IBAction func sliderValueChange(_ sender: UISlider) {
        self.upperValueTextField.text = self.formattedValue(value: Int(self.slider.value))
        
        self.startUpdateResultTimer()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//           super.prepareForReuse()
//           self.titleLabel.text                = nil
//           self.minValueLabel.text             = nil
//           self.maxValueLabel.text             = nil
//           self.upperValueTextField.text       = nil
//           self.upperValueTextField.text       = nil
//           self.slider.isEnabled      = false
//           
//       }
    
    
    func startUpdateResultTimer() {
        
        self.timer?.invalidate()
        
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(updateRequest),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc func updateRequest(){} 
    
    func configure(with model: FilterItemModel, delegate: CreditsListFilterDrawerDelegate? = nil) {
        
//        self.delegate = delegate
        
        
//        guard model.values.count == 2,
//            let minimumValuesModel = model.values.first,
//            let maximumValuesModel = model.values.last else {
//                self.rangeSliderView.isEnabled = false
//                return
//        }
        self.slider.maximumValue = Float(model.maxValue)
        self.slider.minimumValue = Float(model.minValue)
        
        if model.value != nil {
            self.upperValueTextField.text = self.formattedValue(value: Int(model.value))

        }
        self.maxValueLabel.text = self.formattedValue(value: Int(model.maxValue))
        self.minValueLabel.text = self.formattedValue(value: Int(model.minValue))
    }

    
}

extension CreditsListSliderCell {
    func formattedValue<N: Numeric>(value: N) -> String {
        return value.formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
    }
}

extension CreditsListSliderCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        guard let textString = textField.text, let newValue = Float(textString) else {
            print("guard")

            upperValueTextField.text = self.formattedValue(value: self.slider.maximumValue)
            return
        }
        self.slider.value = newValue
        textField.text = self.formattedValue(value: Int(newValue))

    }
    
}


