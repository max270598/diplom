//
//  User.swift
//  VseBankiRu
//
//  Created by Мах Ol on 4/10/20.
//  Copyright © 2020 Мах Ol. All rights reserved.
//

import Foundation
import Firebase

struct UserStr {
    let uid: String
    let email: String?
    
    init(user: User) { //когда мы будем обращаться к бд мы должны будем получить задачи для конкретного пооьзователя, и мы проверяя задачи для текущего пользователя будем получать некого абстрактного пользователя типа User после чего мы сможем присвоить уже конкретному пользователю эти поля. Этот инициализатор нужен нам для того чтобы мы смогли извлечь идентификатор пользователя и его email для того чтобы работать с ними локально
        self.uid = user.uid
        self.email = user.email
    }
}
