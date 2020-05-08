//
//  CalculatorDelegates.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/9/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol CalculatorSliderDelegate: class {
    func sliderValueDidChange(sliderType: SliderType, value: Float)
}
