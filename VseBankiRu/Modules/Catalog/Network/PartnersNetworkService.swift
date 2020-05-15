//
//  PartnersNetworkService.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/14/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase

class PartnersNetworkService {
   static let shared = PartnersNetworkService()
    let ref = Database.database().reference(withPath: "partners")
    
    func getPartners( completion: @escaping (_ partnersArray: [PartnerModel]) -> Void ) {

         var partners = Array<PartnerModel>()
         ref.observe(.value) { (snapshot) in //получаем данные по ref
             for item in snapshot.children {
                 let partner = PartnerModel(snapshot: item as! DataSnapshot)
                 partners.append(partner)
             }
             completion(partners)

         }

     }
}
