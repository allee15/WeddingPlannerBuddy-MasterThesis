//
//  Date+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 28.01.2025.
//

import Foundation

enum DateFormat: String {
    case ddMMYYYY = "dd.MM.yyyy"
    case ddMMYYYY_dash = "dd/MM/yyyy"
    case ddMMMYYYY_space = "dd MMMM yyyy"
    case MMYYYY = "MM/yyyy"
    case HHmm = "HH:mm"
    case dayName = "EEEE"
    case monthName = "MMMM"
    case dd = "dd"
    case ddMM = "dd.MM"
    case yyyyMMdd_dash = "yyyy-MM-dd"
}

extension Date {
    func formatted(dateFormat: DateFormat, locale: String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.locale = Locale(identifier: locale)
        
        let dateAsString = dateFormatter.string(from: self)
        return dateAsString.prefix(1).uppercased() + dateAsString.dropFirst().lowercased()
    }
}
