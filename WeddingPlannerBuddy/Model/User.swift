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
    let hasActiveWedding: Bool
    let tablesAtWedding: [Table]
    let otherWeddings: [WeddingGuest]
    let guests: [Guest]
}

let userMocked = User(id: "1",
                      email: "alexia.elena.aldea@gmail.com",
                      hasActiveWedding: true,
                      tablesAtWedding: [
                        Table(position: CGPoint(x: 0.2, y: 0.3), label: "Table 1", participants: [
                                Guest(id: "1", name: "Daniel", email: "da@gmail.com"),
                                Guest(id: "2", name: "Maria", email: "maria@d.com")
                                ]),
                        Table(position: CGPoint(x: 0.5, y: 0.5), label: "Table 2", participants: [
                            Guest(id: "1", name: "Daniel", email: "da@gmail.com"),
                            Guest(id: "2", name: "Maria", email: "maria@d.com"),
                            Guest(id: "3", name: "Dana", email: "dcsfd@.com")
                            ]),
                        Table(position: CGPoint(x: 0.8, y: 0.7), label: "Table 3", participants: [])
                    ],
                      otherWeddings: [],
                      guests: [])

