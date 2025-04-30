//
//  Weather.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation

struct Weather {
    var id = UUID()
    let latitude: Double
    let longitude: Double
    let date: String
    let prediction: Prediction
}

struct Prediction {
    var id = UUID()
    let minTemperature: Double
    let maxTemperature: Double
    let precipitationProbability: Int
    let condition: String
}
