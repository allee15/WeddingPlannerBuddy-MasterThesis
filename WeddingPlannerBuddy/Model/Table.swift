//
//  Table.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import Foundation

struct Table: Identifiable {
    let id = UUID()
    var position: CGPoint
    var label: String
    var participants: [Guest]
    var isObject: Bool = false
}
