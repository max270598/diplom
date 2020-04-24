//
//  CreditListFavouriteNetwork.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/24/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//


import Foundation
import Firebase

class CreditListFavouriteNetwork {
    static let shared = CreditListFavouriteNetwork()
    
    let ref = Database.database().reference(withPath: "credits").child("all_credits")
    
    
    func getFavouriteCredits( idArray: [String], completion: @escaping (_ creditsArray: [CreditModel]) -> Void ) {
          var credits = Array<CreditModel>()
//        let query = ref.queryOrdered(byChild: "id")
        ref.observe(.value) { (snapshot) in //получаем данные по ref
            for item in snapshot.children {
                
                if let someItem = item as? DataSnapshot {
                    let snapshotValue = someItem.value as! [String: AnyObject]
                    let snapId: String = snapshotValue["id"] as! String
                    idArray.forEach { (id) in //проверяем айдишники в бд и в defaults
                        guard id == snapId else {return}
                        print("ravno")
                        let credit = CreditModel(snapshot: item as! DataSnapshot)
                        credits.append(credit)
                    }
                    

                
                
            }
            
        }
        completion(credits)


    }
}
}
