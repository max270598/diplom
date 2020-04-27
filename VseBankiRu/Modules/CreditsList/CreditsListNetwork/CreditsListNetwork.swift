
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
    
    let ref = Database.database().reference(withPath: "credits").child("all_credits")
    
    
    
    func getCredits( completion: @escaping (_ creditsArray: [CreditModel]) -> Void ) {
        print("ref", ref)

        var credits = Array<CreditModel>()
        ref.observe(.value) { (snapshot) in //получаем данные по ref
            for item in snapshot.children {
                let credit = CreditModel(snapshot: item as! DataSnapshot)
                credits.append(credit)
            }
            completion(credits)

        }

    }
}
