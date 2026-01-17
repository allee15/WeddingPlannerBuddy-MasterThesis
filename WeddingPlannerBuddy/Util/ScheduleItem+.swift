//
//  ScheduleItem+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 18.01.2026.
//

import Foundation

extension ScheduleItem {
    
    func displayText(fallbackDate: String) -> String {
        let displayDate = date.isEmpty ? fallbackDate : date
        
        return "\(displayDate.toPrettyDateString()), \(hour.toPrettyTimeString()) – \(name)"
    }
}
