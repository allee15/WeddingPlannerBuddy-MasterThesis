//
//  Date+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation

extension Date {
    func dateSheetToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        return dateFormatter.string(from: self).capitalized
    }
}
