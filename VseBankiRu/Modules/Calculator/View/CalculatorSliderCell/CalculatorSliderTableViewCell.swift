//
//  CalculatorSliderTableViewCell.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/8/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//




import UIKit

class CalculatorSliderTableViewCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var upperValueTextField: UITextField!
    
    private var filterItem: FilterItemModel?
    /// Таймер чтобы запросы не улетали сразу
       private var timer: Timer?
    var delegate: CalculatorSliderDelegate?
    
    
    var sliderType: SliderType?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

       
        self.upperValueTextField.delegate = self
        
        
        
        // Initialization code
    }
    @IBAction func sliderValueChange(_ sender: UISlider) {
        self.upperValueTextField.text = self.formattedValue(value: (self.slider.value))
            
       passDelegate()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func passDelegate() {
        self.delegate?.sliderValueDidChange(sliderType: self.sliderType ?? .sumSilder, value: self.slider.value)
    }
   
    
    func configure(sliderType: SliderType, value: Float) {
        
        switch sliderType {
        case .sumSilder:
            self.titleLabel.text = "Сумма кредита"
            self.sliderType = .sumSilder
            self.slider.maximumValue = 20000000.0
            self.upperValueTextField.text = self.formattedValue(value: value)
            self.slider.value = value
            self.maxValueLabel.text = self.formattedValue(value: 20000000)
            self.minValueLabel.text = self.formattedValue(value: 0)


        case .rateSlider:
            self.titleLabel.text = "Процентная ставка"
            self.upperValueTextField.keyboardType = .decimalPad
            self.upperValueTextField.placeholder = "7.5 %"
            self.sliderType = .rateSlider
            self.slider.maximumValue = 30
            self.upperValueTextField.text = self.formattedValue(value: value)
            self.slider.value = value
            self.maxValueLabel.text = self.formattedValue(value: 30)
            self.minValueLabel.text = self.formattedValue(value: 0)

        case .timeSlider:
            self.titleLabel.text = "Срок кредита"
            
            self.upperValueTextField.placeholder = "24 мес"
            self.sliderType = .timeSlider
            self.slider.maximumValue = 96
            self.upperValueTextField.text = self.formattedValue(value: value)
            self.slider.value = value
            self.maxValueLabel.text = self.formattedValue(value: 96)
            self.minValueLabel.text = self.formattedValue(value: 0)
        default:
                print("")
        }
        self.slider.minimumValue = 0.0
        
        
        
    }

    
}

extension CalculatorSliderTableViewCell {
    
    func formattedValue(value: Float) -> String {
        switch self.sliderType {
        case .sumSilder:
            return Int(value).formattedWithSeparator + " " + CurrencySymbols.rubles.rawValue
        case .rateSlider:
            return String(format: "%.2f",value) + " " + "%"
        case .timeSlider:
            return String(Int(value)) + " " + "мес"
        default:
            return ""
        }
        
           
       }
    
    
    
    
    
    
}

extension CalculatorSliderTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.,").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        guard let textString = textField.text?.replacingOccurrences(of: ",", with: "."), let newValue = Float(textString) else {
            print("guard")
            
            
            upperValueTextField.text = self.formattedValue(value: self.slider.value)
            
            return
        }
        
        self.slider.value = newValue
        
        
        textField.text = self.formattedValue(value: (self.slider.value))
        
        
        
        
            passDelegate()
    }
    
}


