//
//  JSONParsers.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import SwiftyJSON

class JSONParsers {
    static func parseJsonUser(json: JSON) -> User {
        return User(id: json["userUID"].stringValue,
                    email: json["email"].stringValue,
                    hasActiveWedding: json["hasActiveWedding"].boolValue,
                    tablesAtWedding: json["tablesAtWedding"].array?.map({ subJson in
            parseJsonTables(json: subJson)
        }) ?? [],
                    otherWeddings: json["otherWeddings"].array?.map({ subJson in
            parseJsonOtherWeddings(json: subJson)
        }) ?? [],
                    guests: json["guests"].array?.map({ subJson in
            parseJsonGuest(json: subJson)
        }) ?? [])
    }
    
    static func parseJsonGuest(json: JSON) -> Guest {
        return Guest(id: json["_id"].stringValue,
                     name: json["name"].stringValue,
                     email: json["email"].stringValue)
    }
    
    static func parseJsonOtherWeddings(json: JSON) -> WeddingGuest {
        return WeddingGuest(id: json["_id"].stringValue,
                            tableNb: json["tableNb"].stringValue,
                            date: json["date"].stringValue,
                            location: json["location"].stringValue)
    }
    
    static func parseJsonTables(json: JSON) -> Table {
        return Table(position: CGPoint(x: json["x"].intValue,
                                       y: json["y"].intValue),
                     label: json["label"].stringValue,
                     participants: json["participants"].arrayValue.map({ subJson in
            parseJsonGuest(json: subJson)
        }),
                     isObject: json["isObject"].boolValue)
    }
}
