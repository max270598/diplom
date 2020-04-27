//
//  Double+Extension.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/28/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}
