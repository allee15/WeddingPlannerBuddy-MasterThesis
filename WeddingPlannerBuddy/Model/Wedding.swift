//
//  Wedding.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation

struct Wedding: Codable {
    let id: String
    let name: String
    let date: String
    let location: String
    let images: [String]
    let weddingUUID: String
}
