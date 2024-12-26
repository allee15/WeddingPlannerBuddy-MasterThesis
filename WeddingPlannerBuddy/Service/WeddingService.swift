//
//  WeddingService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine

class WeddingService {
    static let shared = WeddingService()
    private let weddingApi = WeddingApi()
    var bag = Set<AnyCancellable>()
    
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        return weddingApi.getWeddings(userId: userId)
            .eraseToAnyPublisher()
    }
}
