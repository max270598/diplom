//
//  Credit.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase


import InfiniteScrolling




struct CreditModel {
    let id: String!
    let type: String
    let bank_name: String
    let bank_id: String
    let background_image: String
    let bank_logo_url: String
    let credit_url: String
    let sravni_url: String
    let min_rate: Double?
    let min_sum_value: Int
    let max_sum_value: Int
    let goal: String
    let min_time_value: Double
    let max_time_value: Double
    let noDeposit: Bool
    let noIncomeProof: Bool
    let noInsurance: Bool
    let reviewUpThreeDays: Bool
    let short_sum: String
    let short_time: String
    let is_best: Bool
    let description: String
    let rate_description: String
    var ratesTitle: [String] = []
    var ratesValue: [String] = []
    var documentsTitle: [String] = []
    var documentsValue: [String] = []
    var requirementsTitle: [String] = []
    var requirementsValue: [String] = []
    var conditionsTitle: [String] = []
    var conditionsValue: [String] = []

//    let documents: Documents
//    let requirements: Requirements
//    let conditions: Conditions
//    var some_docs: [SomeDocs]
//    var someDocsString: [String]
    
    let ref: DatabaseReference? //все объекты имееют точно е расположение в бд и чтоыб к ним добрать нам нужен из референс, референс опциональный потому что мы создаем его локально, а появляется он тольк окогда попадает в базу данных
    
    init(snapshot: DataSnapshot) { //когда храним данные в базе и хотим получить их, то мы получаем некий snapshot. то есть снимок наших данных на этот момент и чтобы получить эти данные мы должны распотрошить этот snapshot. SnapShot это и есть JSON который мы получаем
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.id = snapshotValue["id"] as! String
        self.type = snapshotValue["type"] as! String
        self.bank_name = snapshotValue["bank_name"] as! String
        self.bank_id = snapshotValue["bank_id"] as! String
        self.background_image = snapshotValue["background_image"] as! String
        self.bank_logo_url = snapshotValue["bank_logo_url"] as! String
        self.credit_url = snapshotValue["credit_url"] as! String
        self.sravni_url = snapshotValue["sravni_url"] as! String
        self.min_rate = snapshotValue["min_rate"] as? Double
        self.min_sum_value = snapshotValue["min_sum_value"] as! Int
        self.max_sum_value = snapshotValue["max_sum_value"] as! Int
        self.goal = snapshotValue["goal"] as! String
        self.min_time_value = snapshotValue["min_time_value"] as! Double
        self.max_time_value = snapshotValue["max_time_value"] as! Double
        self.noDeposit = snapshotValue["noDeposit"] as! Bool
        self.noIncomeProof = snapshotValue["noIncomeProof"] as! Bool
        self.noInsurance = snapshotValue["noInsurance"] as! Bool
        self.reviewUpThreeDays = snapshotValue["reviewUpThreeDays"] as! Bool
        self.short_sum = snapshotValue["short_sum"] as! String
        self.short_time = snapshotValue["short_time"] as! String
        self.is_best = snapshotValue["is_best"] as! Bool

        self.description = snapshotValue["description"] as! String
        self.rate_description = snapshotValue["rate_description"] as! String
        self.ratesTitle = []
        self.ratesValue = []
        
        for item in snapshot.childSnapshot(forPath: "rates").children {
                       let rate = Rate(snapshot: item as! DataSnapshot)
            self.ratesTitle.append(rate.sum)
            self.ratesValue.append(rate.su)
                   }
    
        for item in snapshot.childSnapshot(forPath: "documents").children {
            let doc = SomeDocs(snapshot: item as! DataSnapshot)
            self.some_docs.append(doc)
            self.someDocsString.append(doc.value)
        }
        for item in snapshot.childSnapshot(forPath: "some_doc").children {
            let doc = SomeDocs(snapshot: item as! DataSnapshot)
            self.some_docs.append(doc)
            self.someDocsString.append(doc.value)
        }
        for item in snapshot.childSnapshot(forPath: "some_doc").children {
            let doc = SomeDocs(snapshot: item as! DataSnapshot)
            self.some_docs.append(doc)
            self.someDocsString.append(doc.value)
        }
        self.documents = Documents(snapshot: snapshot.childSnapshot(forPath: "documents"))
        self.requirements = Requirements(snapshot: snapshot.childSnapshot(forPath: "requirements"))
        self.conditions = Conditions(snapshot: snapshot.childSnapshot(forPath: "conditions"))
//
        self.ref = snapshot.ref


    }
}

extension CreditModel {
    
    func inFavorite() -> Bool {
        return CreditListFavouriteService.inFavorite(self.id )
    }
}

struct SomeDocs {
    let value: String
    
    init(snapshot: DataSnapshot) {
         let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.value = snapshotValue["value"] as! String
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
    let title: String
    let value: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.title = snapshotValue["title"] as! String
        self.value = snapshotValue["value"] as! String
    }
}

struct Requirements {
    let title: String
    let value: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.title = snapshotValue["title"] as! String
        self.value = snapshotValue["value"] as! String
    }
}

struct Conditions {
    let title: String
    let value: String
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.title = snapshotValue["title"] as! String
        self.value = snapshotValue["value"] as! String
    }
}


//struct Documents {
//    let mandatoring_documents: String
//    let income_confirmation: String
//    let optional_documents: String
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//
//        self.mandatoring_documents = snapshotValue["mandatoring_documents"] as! String
//        self.income_confirmation = snapshotValue["income_confirmation"] as! String
//        self.optional_documents = snapshotValue["optional_documents"] as! String
//
//
//    }
//}
//
//struct Requirements {
//    let age: String
//    let submitting_requirements: String
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//
//        self.age = snapshotValue["age"] as! String
//        self.submitting_requirements = snapshotValue["submitting_requirements"] as! String
//
//
//    }
//}
//
//struct Conditions {
//    let payment_type: String
//    let payment_period: String
//    let getting_method: String
//    let request_consideration: String
//    let additional_condition: String
//    let time: String
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//
//        self.payment_type = snapshotValue["payment_type"] as! String
//        self.payment_period = snapshotValue["payment_period"] as! String
//        self.getting_method = snapshotValue["getting_method"] as! String
//        self.request_consideration = snapshotValue["request_consideration"] as! String
//        self.additional_condition = snapshotValue["additional_condition"] as! String
//        self.time = snapshotValue["time"] as! String
//
//    }
//}
