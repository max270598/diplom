//
//  BanksCatalogModel.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/7/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase

struct PartnerModel {
    let bankName: String?
    let bankLogoUrl: String?
    let bankId: String?
    
    let ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.bankName = snapshotValue["bank_name"] as? String
        self.bankLogoUrl = snapshotValue["bank_logo_url"] as? String
        self.bankId = snapshotValue["bank_id"] as? String
        
        self.ref = snapshot.ref
    }
}
