//
//  Model.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

struct UserResponse {
    let token: String
    let user: User
}

struct User {
    let id: String
    let email: String
}

let userMocked = User(id: "1",
                      email: "alexia.elena.aldea@gmail.com")

