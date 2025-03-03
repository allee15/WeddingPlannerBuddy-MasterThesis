//
//  WeddingDetails.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation

struct WeddingDetails {
    let id: String
    let date: String
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
