//
//  CreditListFavouriteService.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/23/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//



import Foundation

// MARK: Service for store Favourited AutoMall Items in UserDefaults

struct CreditListFavouriteService {
    
    static private let defaults = UserDefaults.standard
    
    // Favourites Key in UserDefaults
    static private let userDefaultsKey = "CreditListFavourite"
    
    // Favourites list in UserDefaults
    static var favourites: [String] {
        
        if let favoriteItems = defaults.object(forKey: userDefaultsKey) as? [String] {
            return Array(Set(favoriteItems))
        }
        
        return []
    }
    
    // Check Item ID in Favourite
    static func inFavorite(_ itemId: String) -> Bool {
        
//        // Debug Info
//        debugPrint("AutoMallFavouriteService")
//        debugPrint("Item in Favourite: \(itemId)")
//        
//        defer {
//            debugPrint("In Favorite: \(favourites.contains(itemId))")
//        }
        // End. Debug Info
        
        return favourites.contains(itemId)
    }
    
    // Add Item ID in Favourite
    static func addFavorite(_ itemId: String) {
        
        // Debug Info
//        debugPrint("AutoMallFavouriteService")
//        debugPrint("Add Item in Favourite: \(itemId)")
//        debugPrint("AutoMallFavourite List: \(AutoMallFavouriteService.favourites)")
        
//        defer {
//            debugPrint("New AutoMallFavourite List: \(self.favourites)")
//        }
        // End. Debug Info
        
        var newFavourites = CreditListFavouriteService.favourites
        newFavourites.append(itemId)
        defaults.set(newFavourites, forKey: userDefaultsKey)
    }
    
    // Remove Item ID from Favourite
    static func removeFavorite(_ itemId: String) {
        
        // Debug Info
//        debugPrint("AutoMallFavouriteService")
//        debugPrint("Remove Item in Favourite: \(itemId)")
//        debugPrint("AutoMallFavourite List: \(AutoMallFavouriteService.favourites)")
        
//        defer {
//            debugPrint("New AutoMallFavourite List: \(CreditListFavouriteService.favourites)")
//        }
        // End. Debug Info
        
        var newFavourites = CreditListFavouriteService.favourites
        
        if let index = newFavourites.firstIndex(of: itemId) {
            newFavourites.remove(at: index)
            defaults.set(newFavourites, forKey: userDefaultsKey)
        }
    }
}
