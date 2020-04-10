
//
//  Network.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase

class CreditsListNetwork {
    static let shared = CreditsListNetwork()
    
    let ref = Database.database().reference(withPath: "services").child("credits").child("sberbank")
    
    
    func getCredits( completion: @escaping (_ creditsArray: [Credit]) -> Void ) {
        ref.observe(.value) { (snapshot) in //получаем данные по ref
            var credits = Array<Credit>()
            for item in snapshot.children {
                let credit = Credit(snapshot: item as! DataSnapshot)
                credits.append(credit)
                completion(credits)
            }
            
        }
    }
}
