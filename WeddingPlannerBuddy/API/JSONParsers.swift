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
        }) ?? [],
                    weddings: json["weddings"].array?.map({ subJson in
            parseJsonWedding(json: subJson)
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
        return Table(id: json["tableUID"].stringValue,
                     position: CGPoint(x: json["position"]["x"].intValue,
                                       y: json["position"]["y"].intValue),
                     label: json["label"].stringValue,
                     participants: json["participants"].arrayValue.map({ subJson in
            parseJsonGuest(json: subJson)
        }),
                     isObject: json["isObject"].boolValue)
    }
    
    static func parseJsonWedding(json: JSON) -> Wedding {
        return Wedding(id: json["weddingUUID"].stringValue,
                       name: json["name"].stringValue,
                       date: json["date"].stringValue,
                       location: json["location"].stringValue,
                       images: json["images"].array?.compactMap({ $0.stringValue }) ?? [])
    }
    
    static func parseJsonWeddingDetails(json: JSON) -> WeddingDetails {
        return WeddingDetails(id: json["weddingDetailsUUID"].stringValue,
                              date: json["date"].stringValue,
                              price: 3566, //TODO: checkme
                              weddingDress: parseJsonWeddingDress(json: json["weddingDress"]),
                              bouquet: parseJsonBouquet(json: json["bouquet"]),
                              groomSuit: parseJsonGroomSuit(json: json["groomSuit"]),
                              churchCeremony: parseJsonChurchCeremony(json: json["churchCeremony"]),
                              partyLocation: parseJsonPartyLocation(json: json["partyLocation"]),
                              civilMarriage: parseJsonCivilMarriage(json: json["civilMarriage"]),
                              foodMenu: parseJsonFoodMenu(json: json["foodMenu"]),
                              barMenu: parseJsonBarMenu(json: json["barMenu"]),
                              weddingCake: parseJsonWeddingCake(json: json["weddingCake"]),
                              liveBand: parseJsonLiveBand(json: json["liveBand"]))
    }
    
    static func parseJsonWeddingDress(json: JSON) -> WeddingDress {
        return WeddingDress(id: json["weddingDressUUID"].stringValue,
                            link: json["link"].stringValue,
                            price: json["price"].intValue,
                            photo: json["photo"].stringValue,
                            description: json["description"].stringValue)
    }
    
    static func parseJsonBouquet(json: JSON) -> Bouquet {
        return Bouquet(id: json["bouquetUUID"].stringValue,
                       link: json["link"].stringValue,
                       price: json["price"].intValue,
                       photo: json["photo"].stringValue,
                       description: json["description"].stringValue)
    }
    
    static func parseJsonGroomSuit(json: JSON) -> GroomSuit {
        return GroomSuit(id: json["groomSuitUUID"].stringValue,
                         link: json["link"].stringValue,
                         price: json["price"].intValue,
                         photo: json["photo"].stringValue,
                         description: json["description"].stringValue)
    }
    
    static func parseJsonChurchCeremony(json: JSON) -> ChurchCeremony {
        return ChurchCeremony(id: json["churchCeremonyUUID"].stringValue,
                              churchAddress: json["churchAddress"].stringValue,
                              date: json["date"].stringValue,
                              hour: json["hour"].stringValue,
                              preotName: json["preotName"].stringValue,
                              price: json["price"].intValue)
    }
    
    static func parseJsonPartyLocation(json: JSON) -> PartyLocation {
        return PartyLocation(id: json["partyLocationUUID"].stringValue,
                             partyAddress: json["partyAddress"].stringValue,
                             date: json["date"].stringValue,
                             hour: json["hour"].stringValue,
                             decorationsOrganizerDetails: json["decorationsOrganizerDetails"].stringValue,
                             price: json["price"].intValue)
    }
    
    static func parseJsonCivilMarriage(json: JSON) -> CivilMarriage {
        return CivilMarriage(id: json["civilMarriageUUID"].stringValue,
                             address: json["address"].stringValue,
                             date: json["date"].stringValue,
                             hour: json["hour"].stringValue)
    }
    
    static func parseJsonFoodMenu(json: JSON) -> FoodMenu {
        return FoodMenu(id: json["foodMenuUUID"].stringValue,
                        antreu: json["antreu"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                        firstCourse: json["firstCourse"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                        mainCourse: json["mainCourse"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                        secondMainCourse: json["secondMainCourse"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                        price: json["price"].intValue)
    }
    
    static func parseJsonBarMenu(json: JSON) -> BarMenu {
        return BarMenu(id: json["barMenuUUID"].stringValue,
                       alcoholic: json["alcoholic"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                       nonalcoholic: json["nonalcoholic"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                       coffee: json["coffee"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                       juice: json["juice"].arrayValue.map({ subJson in
            return subJson[""].stringValue
        }),
                       price: json["price"].intValue)
    }
    
    static func parseJsonWeddingCake(json: JSON) -> WeddingCake {
        return WeddingCake(id: json["weddingCakeUUID"].stringValue,
                           name: json["name"].stringValue,
                           photo: json["photo"].stringValue,
                           description: json["description"].stringValue,
                           price: json["price"].intValue)
    }
    
    static func parseJsonLiveBand(json: JSON) -> LiveBand {
        return LiveBand(id: json["liveBandUUID"].stringValue,
                        name: json["name"].stringValue,
                        price: json["price"].intValue,
                        hour: json["hour"].stringValue,
                        details: json["details"].stringValue)
    }
}
