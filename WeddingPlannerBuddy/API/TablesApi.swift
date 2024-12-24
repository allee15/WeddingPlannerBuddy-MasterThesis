//
//  TablesApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine

class TablesApi {
    func addTable(table: Table) -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
    func addRectangle(table: Table) -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
    func addParticipant(participant: Guest) -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
}
