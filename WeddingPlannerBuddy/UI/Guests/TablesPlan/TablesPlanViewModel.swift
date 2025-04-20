//
//  TablesPlanViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import Foundation
import Combine
import SwiftUI

enum TablesCompletion {
    case tableAdded
    case failed
    case rectangleAdded
}

class TablesPlanViewModel: BaseViewModel {
    private var tablesService = TablesService.shared
    private var userService = UserService.shared
    @Published var tables: [Table]
    var userId: String
    
    let eventSubject = PassthroughSubject<TablesCompletion, Never>()
    
    init(userId: String, tables: [Table]) {
        self.userId = userId
        self.tables = tables
    }
    
    func reloadUser() {
        self.userService.userReactiveData.reload()
    }
    
    private func getTableNumber() -> Int {
        var counter: Int = 0
        tables.forEach { table in
            if !table.isObject {
                counter += 1
            }
        }
        return counter
    }
    
    func addTable() {
        let newTable = Table(id: "\(UUID())",
                             position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Table \(getTableNumber() + 1)",
                             participants: [])
        tables.append(newTable)
        
        tablesService.addTable(table: newTable, userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.tables.removeAll { $0.label == newTable.label }
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    if let index = self.tables.firstIndex(where: { $0.label == newTable.label }) {
                        self.tables[index] = newTable
                    }
                    self.eventSubject.send(.tableAdded)
                    userService.userReactiveData.reload()
                } else {
                    self.eventSubject.send(.failed)
                }
            }.store(in: &bag)
    }
    
    func addRectangle() {
        let newTable = Table(id: "\(UUID())",
                             position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Object",
                             participants: [],
                             isObject: true)
        tables.append(newTable)
        
        tablesService.addRectangle(table: newTable, userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.tables.removeAll { $0.label == newTable.label }
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    if let index = self.tables.firstIndex(where: { $0.label == newTable.label }) {
                        self.tables[index] = newTable
                    }
                    self.eventSubject.send(.rectangleAdded)
                    userService.userReactiveData.reload()
                } else {
                    self.eventSubject.send(.failed)
                }
            }.store(in: &bag)
    }
    
    func getTableNames(table: Table) -> String {
        var names: String = ""
        table.participants.forEach { participant in
            names += participant.name + "\n"
        }
        return names.isEmpty ? "No one" : names
    }
    
    func updateTablePosition(_ table: Table) {
        tablesService.updateTablePosition(table: table, userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    let toast = Toast(text: "Failed to save position",
                                      textColor: Color.darkRed,
                                      bg: Color.lightRed,
                                      icon: .icToastRed)
                    ToastManager.instance.show(toast)
                }
            } receiveValue: { _ in
            }
            .store(in: &bag)
    }

}
