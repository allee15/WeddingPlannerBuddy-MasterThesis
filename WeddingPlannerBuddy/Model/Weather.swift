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
    let startDate: String
    let endDate: String
    let predictions: [Prediction]
}

struct Prediction {
    var id = UUID()
    let date: String
    let minTemperature: Double
    let maxTemperature: Double
    let precipitationProbability: Int
    let condition: String
}

let mockedWeather = Weather(
    latitude: 45.764043,
    longitude: 4.835659,
    startDate: "2025-06-01",
    endDate: "2025-06-15",
    predictions: [
        Prediction(
            date: "01-06-2025",
            minTemperature: 18.0,
            maxTemperature: 27.5,
            precipitationProbability: 20,
            condition: "Sunny"
        ),
        Prediction(
            date: "02-06-2025",
            minTemperature: 17.5,
            maxTemperature: 26.0,
            precipitationProbability: 40,
            condition: "Partly Cloudy"
        ),
        Prediction(
            date: "03-06-2025",
            minTemperature: 19.0,
            maxTemperature: 28.0,
            precipitationProbability: 10,
            condition: "Snowy"
        ),
        Prediction(
            date: "04-06-2025",
            minTemperature: 16.5,
            maxTemperature: 25.0,
            precipitationProbability: 50,
            condition: "Rainy"
        )
    ]
)

