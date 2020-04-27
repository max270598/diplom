//
//  Formatter.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

class Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    static func formatPoints(num: Double) ->String{
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum)) тыс")
            }
            return("\(thousandNum.roundToPlaces(places: 1)) тыс")
        }
        if num >= 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(millionNum)) млн")
            }
            return ("\(millionNum.roundToPlaces(places: 1)) млн")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }

    }
}
