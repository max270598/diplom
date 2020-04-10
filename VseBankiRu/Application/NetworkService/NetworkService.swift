//
//  NetworkService.swift
//  VseBankiRu
//
//  Created by Мах Ol on 2/28/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

class  NetworkService {
    private init(){}
    static let shared = NetworkService()
    
    
    
    
    public func getData(url: URL, completion: @escaping (Any) -> ()) {
        let session = URLSession.shared
    
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    completion(json)
                }
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
