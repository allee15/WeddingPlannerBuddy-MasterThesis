//
//  WeatherApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation
import Combine

class WeatherApi {
    func getWeather(startDate: Date, endDate: Date? = nil, latitude: Double, longitude: Double) -> AnyPublisher<Weather, Error> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                do {
                    promise(.success(mockedWeather))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

/*{
  "location": {
    "latitude": 45.764043,
    "longitude": 4.835659
  },
  "dateRange": {
    "startDate": "2025-06-01",
    "endDate": "2025-06-15"
  },
  "predictions": [
    {
      "date": "2025-06-01",
      "temperature": {
        "min": 18.0,
        "max": 27.5
      },
      "precipitationProbability": 20,
      "condition": "Sunny"
    },
    {
      "date": "2025-06-02",
      "temperature": {
        "min": 17.5,
        "max": 26.0
      },
      "precipitationProbability": 40,
      "condition": "Partly Cloudy"
    }
    // ... Alte zile
  ],
  "averageScore": 8.5
}
*/
