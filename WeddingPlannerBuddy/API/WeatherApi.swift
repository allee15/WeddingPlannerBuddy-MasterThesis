//
//  WeatherApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation
import Combine
import SwiftyJSON

class WeatherApi {
    func getWeather(startDate: Date, endDate: Date? = nil, latitude: Double, longitude: Double) -> AnyPublisher<[Weather], Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/weather/prediction")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "latitude": latitude,
                "longitude": longitude,
                "start_date": startDate.formatted(dateFormat: .yyyyMMdd_dash),
                "end_date": endDate?.formatted(dateFormat: .yyyyMMdd_dash) ?? startDate.formatted(dateFormat: .yyyyMMdd_dash)
            ]
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let weddingDetails = JSONParsers.parseJsonWeatherArray(json: json)
                        promise(.success(weddingDetails))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }
        .eraseToAnyPublisher()
    }
}

/*
 {
   "latitude": 45.764043,
   "longitude": 4.835659,
   "date": "2025-06-01",
   "prediction": {
     "minTemperature": 18.0,
     "maxTemperature": 27.5,
     "precipitationProbability": 20,
     "condition": "Sunny"
   }
 }
 */
