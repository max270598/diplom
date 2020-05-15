//
//  QuotationNetworkService.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/28/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//
import Foundation

class QuotationNetworkService {
    static let shared = QuotationNetworkService()
    func getData(urlString: String, complition: @escaping (_ result: [QuotationModel]) -> Void ) {
        
            
        
        guard let url = URL(string: urlString) else { return }
      
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
                do {
                                let quotation = try JSONDecoder().decode(Array<QuotationModel>.self, from: data)
                    DispatchQueue.main.async {
                                                        complition(quotation)

                    }
                               
                            } catch let jsonError {
                                print("someError happend", jsonError)
                            }
                        
        }.resume()
            
            
        
//         complition(quotation)
        
    }
}
