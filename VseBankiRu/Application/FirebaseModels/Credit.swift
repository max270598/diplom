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
    let procent: String
    let sum: String
    let time: String
    let type: String
    
    let ref: DatabaseReference? //все объекты имееют точно е расположение в бд и чтоыб к ним добрать нам нужен из референс, референс опциональный потому что мы создаем его локально, а появляется он тольк окогда попадает в базу данных
    
    init(snapshot: DataSnapshot) { //когда храним данные в базе и хотим получить их, то мы получаем некий snapshot. то есть снимок наших данных на этот момент и чтобы получить эти данные мы должны распотрошить этот snapshot. SnapShot это и есть JSON который мы получаем
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.id = snapshotValue["id"] as! String
        self.procent = snapshotValue["procent"] as! String
        self.sum = snapshotValue["sum"] as! String
        self.time = snapshotValue["time"] as! String
        self.type = snapshotValue["type"] as! String
        
        self.ref = snapshot.ref
    }
}
