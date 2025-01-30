//
//  WeddingApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit

class WeddingApi {
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        Future { promise in
            promise(.success(weddingsMocked))
        }.eraseToAnyPublisher()
    }
    
    func addImage(image: UIImage?) -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
    func getWeddingDetails() -> AnyPublisher<WeddingDetails, Error> {
        Future { promise in
            promise(.success(weddingDetailsMocked))
        }.eraseToAnyPublisher()
    }
}
