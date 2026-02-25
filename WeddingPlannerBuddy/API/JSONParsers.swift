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
        let guests = json["guests"].arrayValue.map(parseJsonGuest)
        
        let tables = json["tablesAtWedding"].arrayValue.map { subJson in
            parseJsonTableWithGuests(json: subJson, allGuests: guests)
        }
        
        let parsedOtherWeddings = json["otherWeddings"].arrayValue.map(parseJsonOtherWeddings)

        var seenWeddingUUIDs = Set<String>()
        let uniqueOtherWeddings = parsedOtherWeddings.filter { wg in
            if seenWeddingUUIDs.contains(wg.weddingUUID.id) {
                return false
            } else {
                seenWeddingUUIDs.insert(wg.weddingUUID.id)
                return true
            }
        }
        
        return User(
            id: json["userUID"].stringValue,
            email: json["email"].stringValue,
            hasActiveWedding: json["hasActiveWedding"].boolValue,
            tablesAtWedding: tables,
            otherWeddings: uniqueOtherWeddings,
            guests: guests,
            weddings: json["weddings"].arrayValue.map(parseJsonWedding)
        )
    }
    
    static func parseJsonTableWithGuests(json: JSON, allGuests: [Guest]) -> Table {
        let tableUID = json["tableUID"].stringValue

        let participants = allGuests.filter { $0.tableUID == tableUID }

        return Table(
            id: tableUID,
            position: CGPoint(
                x: json["position"]["x"].doubleValue,
                y: json["position"]["y"].doubleValue
            ),
            label: json["label"].stringValue,
            participants: participants,
            isObject: json["isObject"].boolValue
        )
    }
    
    static func parseJsonGuest(json: JSON) -> Guest {
        return Guest(
            id: json["_id"].stringValue,
            name: json["name"].stringValue,
            email: json["email"].stringValue,
            tableUID: json["tableUID"].stringValue
        )
    }
    
    static func parseJsonOtherWeddings(json: JSON) -> WeddingGuest {
        return WeddingGuest(id: json["_id"].stringValue,
                            tableNb: json["tableNb"].stringValue,
                            date: json["date"].stringValue,
                            location: json["location"].stringValue,
                            weddingUUID: parseJsonWedding(json: json["weddingUUID"]))
    }
    
    static func parseJsonWedding(json: JSON) -> Wedding {
        return Wedding(id: json["_id"].stringValue,
                       name: json["name"].stringValue,
                       date: json["date"].stringValue,
                       location: json["location"].stringValue,
                       images: json["images"].array?.compactMap({ $0.stringValue }) ?? [],
                       weddingUUID: json["weddingUUID"].stringValue)
    }
    
    static func parseJsonWeddingDetails(json: JSON) -> WeddingDetails {
        return WeddingDetails(id: json["weddingDetailsUUID"].stringValue,
                              date: json["date"].stringValue,
                              price: getPrice(json: json),
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
    
    static func getPrice(json: JSON) -> Int {
        return json["weddingDress"]["price"].intValue + json["bouquet"]["price"].intValue + json["groomSuit"]["price"].intValue + json["churchCeremony"]["price"].intValue + json["partyLocation"]["price"].intValue + json["foodMenu"]["price"].intValue + json["barMenu"]["price"].intValue + json["weddingCake"]["price"].intValue + json["liveBand"]["price"].intValue
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
                        antreu: json["antreu"].arrayValue.map({ $0.stringValue }),
                        firstCourse: json["firstCourse"].arrayValue.map({ $0.stringValue }),
                        mainCourse: json["mainCourse"].arrayValue.map({ $0.stringValue }),
                        secondMainCourse: json["secondMainCourse"].arrayValue.map({ $0.stringValue }),
                        price: json["price"].intValue)
    }
    
    static func parseJsonBarMenu(json: JSON) -> BarMenu {
        return BarMenu(id: json["barMenuUUID"].stringValue,
                       alcoholic: json["alcoholic"].arrayValue.map({ $0.stringValue }),
                       nonalcoholic: json["nonalcoholic"].arrayValue.map({ $0.stringValue }),
                       coffee: json["coffee"].arrayValue.map({ $0.stringValue }),
                       juice: json["juice"].arrayValue.map({ $0.stringValue }),
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
    
    static func parseJsonWeatherArray(json: JSON) -> [Weather] {
        return json.arrayValue.map { subJson in
            parseJsonWeather(json: subJson)
        }
    }
    
    static func parseJsonWeather(json: JSON) -> Weather {
        return Weather(latitude: json["latitude"].doubleValue,
                       longitude: json["longitude"].doubleValue,
                       date: json["date"].stringValue,
                       prediction: parseJsonPrediction(json: json["prediction"]))
    }
    
    static func parseJsonPrediction(json: JSON) -> Prediction {
        return Prediction(minTemperature: json["minTemperature"].doubleValue,
                          maxTemperature: json["maxTemperature"].doubleValue,
                          precipitationProbability: json["precipitationProbability"].intValue,
                          condition: json["condition"].stringValue)
    }
    
    static func parseJsonNewUserGuest(json: JSON) -> NewUserGuest {
        return NewUserGuest(id: json["guestUUID"].stringValue,
                            email: json["email"].stringValue,
                            password: json["password"].stringValue)
    }
}
