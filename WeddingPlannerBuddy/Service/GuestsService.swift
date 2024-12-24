//
//  GuestsService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine

class GuestsService {
    static let shared = GuestsService()
    private let guestsApi = GuestsApi()
    var bag = Set<AnyCancellable>()
    
    func startWedding() -> AnyPublisher<Bool, Error> {
        return guestsApi.startWedding()
            .eraseToAnyPublisher()
    }
}
