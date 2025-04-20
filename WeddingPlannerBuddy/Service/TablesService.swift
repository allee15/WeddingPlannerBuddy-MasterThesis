//
//  TablesService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine

class TablesService {
    static let shared = TablesService()
    private let tablesApi = TablesApi()
    var bag = Set<AnyCancellable>()
    
    func addTable(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.addTable(table: table, userId: userId)
            .eraseToAnyPublisher()
    }
    
    func addRectangle(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.addRectangle(table: table, userId: userId)
            .eraseToAnyPublisher()
    }
    
    func addParticipant(participant: Guest, userId: String, tableUUID: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.addParticipant(participant: participant, userId: userId, tableId: tableUUID)
            .eraseToAnyPublisher()
    }
    
    func updateTablePosition(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.updateTablePosition(table: table, userId: userId)
            .eraseToAnyPublisher()
    }
}
