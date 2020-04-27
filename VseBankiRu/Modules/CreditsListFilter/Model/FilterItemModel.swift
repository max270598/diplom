//
//  CreditFilterModel.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

struct FilterItemModel {
    var bankName: String? //банк
    var goal: String? //цель
    var time: Int? //срок
    var maxValue: Int //максимальная сумма
    var minValue: Int //минимальная сумма
    var value: Int //сумма
    var noInsurance: Bool? //страховка //wo = with out
    var noDeposit: Bool? //Залог
    var noIncomeProof: Bool? //Подтверждение дохода
    var noReviewUpThreeDays: Bool? //Рассмотрение до 3 дней
    
    
}

