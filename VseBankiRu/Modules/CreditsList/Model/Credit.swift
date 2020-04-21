//
//  Credit.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase

struct Credit {
    let id: String
    let bank_url: String
    let sravni_url: String
    let short_sum: String
    let min_rate: String
    let full_sum: String
    let full_time: String
    let max_time: String
    let description: String
    let rate_description: String
    var rates: [Rate]
    let documents: Documents
    let requirements: Requirements
    let conditions: Conditions
    
    let ref: DatabaseReference? //все объекты имееют точно е расположение в бд и чтоыб к ним добрать нам нужен из референс, референс опциональный потому что мы создаем его локально, а появляется он тольк окогда попадает в базу данных
    
    init(snapshot: DataSnapshot) { //когда храним данные в базе и хотим получить их, то мы получаем некий snapshot. то есть снимок наших данных на этот момент и чтобы получить эти данные мы должны распотрошить этот snapshot. SnapShot это и есть JSON который мы получаем
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.id = snapshotValue["id"] as! String
        self.bank_url = snapshotValue["bank_url"] as! String

        self.sravni_url = snapshotValue["sravni_url"] as! String

        self.short_sum = snapshotValue["short_sum"] as! String
        self.min_rate = snapshotValue["min_rate"] as! String
        self.full_sum = snapshotValue["full_sum"] as! String
        self.full_time = snapshotValue["full_time"] as! String
        self.max_time = snapshotValue["max_time"] as! String
        self.description = snapshotValue["description"] as! String
        self.rate_description = snapshotValue["rate_description"] as! String
        self.rates = []
        for item in snapshot.childSnapshot(forPath: "rates").children {
                       let rate = Rate(snapshot: item as! DataSnapshot)
                    self.rates.append(rate)
                   }
        self.documents = Documents(snapshot: snapshot.childSnapshot(forPath: "documents"))
        self.requirements = Requirements(snapshot: snapshot.childSnapshot(forPath: "requirements"))
        self.conditions = Conditions(snapshot: snapshot.childSnapshot(forPath: "conditions"))
        
        self.ref = snapshot.ref


    }
}

struct Rate {
    let sum: String
    let rate: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.sum = snapshotValue["sum"] as! String
        self.rate = snapshotValue["rate"] as! String


    }
}

struct Documents {
    let mandatoring_documents: String
    let income_confirmation: String
    let optional_documents: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.mandatoring_documents = snapshotValue["mandatoring_documents"] as! String
        self.income_confirmation = snapshotValue["income_confirmation"] as! String
        self.optional_documents = snapshotValue["optional_documents"] as! String


    }
}

struct Requirements {
    let age: String
    let submitting_requirements: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.age = snapshotValue["age"] as! String
        self.submitting_requirements = snapshotValue["submitting_requirements"] as! String


    }
}

struct Conditions {
    let payment_type: String
    let payment_period: String
    let getting_method: String
    let request_consideration: String
    let additional_condition: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.payment_type = snapshotValue["payment_type"] as! String
        self.payment_period = snapshotValue["payment_period"] as! String
        self.getting_method = snapshotValue["getting_method"] as! String
        self.request_consideration = snapshotValue["request_consideration"] as! String
        self.additional_condition = snapshotValue["additional_condition"] as! String

    }
}
