//
//  TablesPlanViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import Foundation
import Combine

enum TablesCompletion {
    case tableAdded
    case failed
    case rectangleAdded
}

class TablesPlanViewModel: BaseViewModel {
    private var tablesService = TablesService.shared
    @Published var tables: [Table]
    
    let eventSubject = PassthroughSubject<TablesCompletion, Never>()
    
    init(tables: [Table]) {
        self.tables = tables
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
        let newTable = Table(position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Table \(getTableNumber() + 1)",
                             participants: [])
        tables.append(newTable)
        
        tablesService.addTable(table: newTable)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.tables.removeAll { $0.label == newTable.label }
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
//                if let index = self.tables.firstIndex(where: { $0.label == newTable.label }) {
//                    self.tables[index] = result
//                }
                if result {
                    self.eventSubject.send(.tableAdded)
                } else {
                    self.eventSubject.send(.failed)
                }
            }.store(in: &bag)
    }
    
    func addRectangle() {
        let newTable = Table(position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Object",
                             participants: [],
                             isObject: true)
        tables.append(newTable)
        
        tablesService.addTable(table: newTable)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.tables.removeAll { $0.label == newTable.label }
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
//                if let index = self.tables.firstIndex(where: { $0.label == newTable.label }) {
//                    self.tables[index] = result
//                }
                if result {
                    self.eventSubject.send(.rectangleAdded)
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
}
