//
//  WeddingService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit

class WeddingService {
    static let shared = WeddingService()
    private let weddingApi = WeddingApi()
    var bag = Set<AnyCancellable>()
    
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        return weddingApi.getWeddings(userId: userId)
            .eraseToAnyPublisher()
    }
    
    func addImage(image: UIImage?) -> AnyPublisher<Bool, Error> {
        return weddingApi.addImage(image: image)
            .eraseToAnyPublisher()
    }
    
    func getWeddingDetails() -> AnyPublisher<WeddingDetails, Error> {
        return weddingApi.getWeddingDetails()
            .eraseToAnyPublisher()
    }
}
