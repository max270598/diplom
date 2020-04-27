//
//  CreditFilterModel.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

struct FilterItemModel {
    var bankName: String //банк
    var goal: String //цель
    var time: String //срок
    var maxValue: Int //максимальная сумма
    var minValue: Int //минимальная сумма
    var value: Int //сумма
    var insurance: Bool //страховка
    var deposit: Bool //Залог
    var incomeProof: Bool //Подтверждение дохода
    var reviewUpThreeDays: Bool //Рассмотрение до 3 дней
}

struct asdasd {
    var value: [String: String]
    value = ["Банки": "Сюерюак"]
}
