//
//  CreditsListFilterDrawerDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/27/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//


import Foundation

protocol CreditsListFilterDrawerDelegate: class {
    
    func updateFilterParams(with params: [String: String])
}
