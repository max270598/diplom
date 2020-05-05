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
    
    static func repalceWithStringSpace(text: String?) -> String {
        var i = text?.replacingOccurrences(of: "*", with: "\n\n- ") ?? ""
        i = i.replacingOccurrences(of: "|", with: "\n\n")
        return i

    }
    
    static func formatTimeStringToDouble(text: String ) -> Double {
        switch text {
        case "Любой": return 0
        case "1 месяц": return 0.1
        case "3 месяца":return 0.3
        case "6 месяцев":return 0.6
        case "9 месяцев": return 0.9
        case "1 год":return 1
        case "1,5 года":return 1.5
        case "2 года":return 2
        case "3 года":return 3
        case "4 года":return 4
        case "5 лет":return 5
        case "6 лет":return 6
        case "7 лет":return 7
        case "10 лет":return 10
        case "15 лет":return 15
        case "20 лет":return 20
        case "25 лет":return 25
        case "30 лет":return 30
        default:
            return -1
        }
    }
    
    static func formatTimeDoubleToString(num: Double) -> String {
        switch num {
        case 0: return "Любой"
        case 0.1: return "1 месяц"
        case 0.3: return "3 месяца"
        case 0.6: return "6 месяцев"
        case 0.9: return "9 месяцев"
        case 1: return "1 год"
        case 1.5: return "1,5 года"
        case 2: return "2 года"
       case 3: return "3 года"
       case 4: return "4 года"
       case 5: return "5 лет"
       case 6: return "6 лет"
       case 7: return "7 лет"
       case 10: return "10 лет"
       case 15: return "15 лет"
       case 20: return "20 лет"
       case 25: return "25 лет"
        case 30: return "30 лет"
            
        default:
            return ""
        }
    }
    
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
