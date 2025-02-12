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

let weddingdressMocked = WeddingDress(
    id: "1",
    link: "https://example.com/dress",
    price: 1200,
    photo: "https://example.com/dress.jpg",
    description: "Elegant white lace wedding dress with a long train."
)

let bouquetMocked = Bouquet(
    id: "1",
    link: "https://example.com/bouquet",
    price: 150,
    photo: "https://example.com/bouquet.jpg",
    description: "Beautiful mix of roses and peonies in soft pastel colors."
)

let groomSuitMocked = GroomSuit(
    id: "1",
    link: "https://example.com/suit",
    price: 800,
    photo: "https://example.com/suit.jpg",
    description: "Classic black tuxedo with a modern slim fit."
)

let churchCeremonyMocked = ChurchCeremony(
    id: "1",
    churchAddress: "123 Church St, Cityville",
    date: "2025-06-15",
    hour: "14:00",
    preotName: "Father John Doe",
    price: 500
)

let partyLocationMocked = PartyLocation(
    id: "1",
    partyAddress: "456 Banquet Hall, Cityville",
    date: "2025-06-15",
    hour: "19:00",
    decorationsOrganizerDetails: "Decor by Elegant Weddings - includes floral arrangements and lighting."
    ,price: 5000
)

let civilMarriageMocked = CivilMarriage(
    id: "1",
    address: "789 City Hall, Cityville",
    date: "2025-06-10",
    hour: "11:00"
)

let foodMenuMocked = FoodMenu(
    id: "1",
    antreu: ["Bruschetta with tomato and basil", "Stuffed mushrooms"],
    firstCourse: ["Pumpkin soup", "Creamy mushroom soup"],
    mainCourse: ["Grilled salmon with asparagus", "Roast beef with mashed potatoes"],
    secondMainCourse: ["Chicken in creamy sauce", "Vegetarian lasagna"],
    price: 120
)

let barMenuMocked = BarMenu(
    id: "1",
    alcoholic: ["Red wine", "White wine", "Cocktails"],
    nonalcoholic: ["Soda", "Mineral water"],
    coffee: ["Espresso", "Cappuccino"],
    juice: ["Orange juice", "Apple juice"],
    price: 50
)

let weddingCakeMocked = WeddingCake(
    id: "1",
    name: "Chocolate & Raspberry Delight",
    photo: "https://example.com/cake.jpg",
    description: "Four-tier chocolate cake with raspberry filling and vanilla frosting.",
    price: 300
)

let liveBandMocked = LiveBand(
    id: "1",
    name: "The Wedding Band",
    price: 2000,
    hour: "21:00",
    details: "5-piece live band playing a mix of pop, jazz, and classic hits."
)
