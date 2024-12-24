//
//  JSONParsers.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import SwiftyJSON

class JSONParsers {
    static func parseJsonUserResponse(json: JSON) -> UserResponse {
        return UserResponse(token: json["token"].stringValue,
                            user: parseJsonUser(json: json))
    }
    
    static func parseJsonUser(json: JSON) -> User {
        return User(id: json["id"].stringValue,
                    email: json["email"].stringValue,
                    hasActiveWedding: json["hasActiveWedding"].boolValue,
                    tablesAtWedding: [],
                    otherWeddings: [],
                    guests: [])
    }
}
