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
    
    func addTable(table: Table) -> AnyPublisher<Bool, Error> {
        return tablesApi.addTable(table: table)
            .eraseToAnyPublisher()
    }
    
    func addRectangle(table: Table) -> AnyPublisher<Bool, Error> {
        return tablesApi.addRectangle(table: table)
            .eraseToAnyPublisher()
    }
    
    func addParticipant(participant: Guest) -> AnyPublisher<Bool, Error> {
        return tablesApi.addParticipant(participant: participant)
    }
}
