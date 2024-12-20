//
//  TablesPlanViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import Foundation

class TablesPlanViewModel: BaseViewModel {
    @Published var tables: [Table]
    
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
        //TODO send also to service
    }
    
    func addRectangle() {
        let newTable = Table(position: CGPoint(x: Double.random(in: 0.1...0.9), y: Double.random(in: 0.1...0.8)),
                             label: "Object",
                             participants: [],
                             isObject: true)
        tables.append(newTable)
        //TODO send also to service
    }
    
    func getTableNames(table: Table) -> String {
        var names: String = ""
        table.participants.forEach { participant in
            names += participant.name + "\n"
        }
        return names.isEmpty ? "No one" : names
    }
}
