//
//  WeatherService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation
import Combine

class WeatherService {
    static let shared = WeatherService()
    private let weatherApi = WeatherApi()
    var bag = Set<AnyCancellable>()
    
    func getWeather(startDate: Date, endDate: Date?,
                    latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error> {
        return weatherApi.getWeather(startDate: startDate, endDate: endDate,
                                     latitude: latitude, longitude: longitude)
            .eraseToAnyPublisher()
    }
}
