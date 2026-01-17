//
//  WeddingDetails.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import SwiftUICore

struct WeddingDetails {
    let id: String
    let date: String
    let price: Int
    let weddingDress: WeddingDress
    let bouquet: Bouquet
    let groomSuit: GroomSuit
    let churchCeremony: ChurchCeremony
    let partyLocation: PartyLocation
    let civilMarriage: CivilMarriage
    let foodMenu: FoodMenu
    let barMenu: BarMenu
    let weddingCake: WeddingCake
    let liveBand: LiveBand
}

struct WeddingDress {
    let id: String
    let link: String
    let price: Int
    let photo: String
    let description: String
}

struct Bouquet {
    let id: String
    let link: String
    let price: Int
    let photo: String
    let description: String
}

struct GroomSuit {
    let id: String
    let link: String
    let price: Int
    let photo: String
    let description: String
}

struct ChurchCeremony {
    let id: String
    let churchAddress: String
    let date: String
    let hour: String
    let preotName: String
    let price: Int
}

struct PartyLocation {
    let id: String
    let partyAddress: String
    let date: String
    let hour: String
    let decorationsOrganizerDetails: String
    let price: Int
}

struct CivilMarriage {
    let id: String
    let address: String
    let date: String
    let hour: String
}

struct FoodMenu {
    let id: String
    let antreu: [String]
    let firstCourse: [String]
    let mainCourse: [String]
    let secondMainCourse: [String]
    let price: Int
}

struct BarMenu {
    let id: String
    let alcoholic: [String]
    let nonalcoholic: [String]
    let coffee: [String]
    let juice: [String]
    let price: Int
}

struct WeddingCake {
    let id: String
    let name: String
    let photo: String
    let description: String
    let price: Int
}

struct LiveBand {
    let id: String
    let name: String
    let price: Int
    let hour: String
    let details: String
}

struct PriceItem {
    let name: String
    let price: Int
    let color: Color
}

struct ScheduleItem {
    let name: String
    let date: String
    let hour: String
}

extension WeddingDetails {
    
    var priceItems: [PriceItem] {
        var items: [PriceItem] = []

        items.append(PriceItem(name: "Wedding dress", price: weddingDress.price, color: Color(hex: "#FF7F3A")))
        items.append(PriceItem(name: "Bouquet", price: bouquet.price, color: Color(hex: "#E85678")))
        items.append(PriceItem(name: "Groom suit", price: groomSuit.price, color: Color(hex: "#37B5EF")))
        items.append(PriceItem(name: "Church ceremony", price: churchCeremony.price, color: Color(hex: "#3DC269")))
        items.append(PriceItem(name: "Party location", price: partyLocation.price, color: Color(hex: "#EB9D34")))
        items.append(PriceItem(name: "Food menu", price: foodMenu.price, color: Color(hex: "#2B2A2C")))
        items.append(PriceItem(name: "Bar menu", price: barMenu.price, color: Color(hex: "#F91E4A")))
        items.append(PriceItem(name: "Wedding cake", price: weddingCake.price, color: Color(hex: "#9400BD")))
        items.append(PriceItem(name: "Live band", price: liveBand.price, color: Color(hex: "#00C2A8")))

        return items
    }

    var scheduleItems: [ScheduleItem] {
        var items: [ScheduleItem] = []

        items.append(
            ScheduleItem(
                name: "Church ceremony",
                date: churchCeremony.date,
                hour: churchCeremony.hour
            )
        )

        items.append(
            ScheduleItem(
                name: "Party location",
                date: partyLocation.date,
                hour: partyLocation.hour
            )
        )

        items.append(
            ScheduleItem(
                name: "Civil marriage",
                date: civilMarriage.date,
                hour: civilMarriage.hour
            )
        )
        
        items.append(
            ScheduleItem(
                name: "Live band",
                date: "",
                hour: liveBand.hour
            )
        )

        return items
    }
}
