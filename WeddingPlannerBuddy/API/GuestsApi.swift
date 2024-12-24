//
//  GuestsApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine

class GuestsApi {
    func startWedding() -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true)) //hasActiveWedding = true
        }.eraseToAnyPublisher()
    }
}
