//
//  WeddingDetails+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 18.01.2026.
//

import Foundation
import SwiftUI

extension WeddingDetails {
    
    var priceItems: [PriceItem] {
        var items: [PriceItem] = []

        items.append(PriceItem(name: "Dress", price: weddingDress.price, color: Color(hex: "#FF7F3A")))
        items.append(PriceItem(name: "Bouquet", price: bouquet.price, color: Color(hex: "#E85678")))
        items.append(PriceItem(name: "Groom suit", price: groomSuit.price, color: Color(hex: "#37B5EF")))
        items.append(PriceItem(name: "Church marriage", price: churchCeremony.price, color: Color(hex: "#3DC269")))
        items.append(PriceItem(name: "After-party", price: partyLocation.price, color: Color(hex: "#EB9D34")))
        items.append(PriceItem(name: "Menu for food", price: foodMenu.price, color: Color(hex: "#2B2A2C")))
        items.append(PriceItem(name: "Menu for drink", price: barMenu.price, color: Color(hex: "#F91E4A")))
        items.append(PriceItem(name: "Cake", price: weddingCake.price, color: Color(hex: "#9400BD")))
        items.append(PriceItem(name: "Band", price: liveBand.price, color: Color(hex: "#00C2A8")))

        return items
    }

    var scheduleItems: [ScheduleItem] {
        var items: [ScheduleItem] = []

        items.append(
            ScheduleItem(
                name: "Legal marriage",
                date: civilMarriage.date,
                hour: civilMarriage.hour
            )
        )
        
        items.append(
            ScheduleItem(
                name: "Church marriage",
                date: churchCeremony.date,
                hour: churchCeremony.hour
            )
        )

        items.append(
            ScheduleItem(
                name: "After-party",
                date: partyLocation.date,
                hour: partyLocation.hour
            )
        )
        
        items.append(
            ScheduleItem(
                name: "Band",
                date: partyLocation.date,
                hour: liveBand.hour
            )
        )

        return items
    }
}
