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
    
    @Published var newGuests: [NewUserGuest] = []
    
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
            .handleEvents(receiveOutput: { [weak self] success, newGuest in
                if success {
                    self?.newGuests.append(newGuest)
                }
            })
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
    
    func updateTablePosition(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.updateTablePosition(table: table, userId: userId)
            .eraseToAnyPublisher()
    }
    
    func deleteTableOrObject(tableId: String, userId: String) -> AnyPublisher<Bool, Error> {
        return tablesApi.deleteTableOrObject(tableId: tableId, userId: userId)
            .eraseToAnyPublisher()
    }
}
