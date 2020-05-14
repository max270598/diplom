//
//  CreditsDetailDelegate.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/4/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol CreditsDetailDelegate {
    func segmentDidChange(index: Int)
    func removeCell(at index: Int)
}


