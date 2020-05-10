//
//  PrivateOfficeDelegates.swift
//  VseBankiRu
//
//  Created by Мах Ol on 5/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation

protocol emailPhoneChanged {
    func changeEmail(email: String)
    func changePhone(phoneNumber: String)
}

protocol aboutHelpDelegate {
    func showAboutApp()
    func showHelp()
}
