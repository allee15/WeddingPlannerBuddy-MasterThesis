//
//  TablesPlanViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import Foundation

class TablesPlanViewModel: BaseViewModel {
    @Published var tables = [
        Table(position: CGPoint(x: 0.2, y: 0.3), label: "Table 1", participants: ["Daniel", "Maria"]),
        Table(position: CGPoint(x: 0.5, y: 0.5), label: "Table 2", participants: ["Daniel", "Maria", "Anca"]),
        Table(position: CGPoint(x: 0.8, y: 0.7), label: "Table 3", participants: [])
    ]
    
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
    }
    
    func addRectangle() {
        let newTable = Table(position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Object",
                             participants: [],
                             isObject: true)
        tables.append(newTable)
    }
    
    func getTableNames(table: Table) -> String {
        var names: String = ""
        table.participants.forEach { participant in
            names += participant + "\n"
        }
        return names.isEmpty ? "No one" : names
    }
    
    func addParticipantToTable(tableToAdd: Table, name: String) {
        if let index = tables.firstIndex(where: { $0.id == tableToAdd.id }) {
            tables[index].participants.append(name)
        }
    }
}
