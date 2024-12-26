//
//  WeddingApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine

class WeddingApi {
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        Future { promise in
            promise(.success(weddingsMocked))
        }.eraseToAnyPublisher()
    }
}
