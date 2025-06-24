//
//  String+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9\\+\\.\\_\\%\\-]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func replaceSpacesWithUnderscores() -> String {
        return self.replacingOccurrences(of: " ", with: "_")
    }
    
    func remakeWeather() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM yyyy"
        
        if let date = inputFormatter.date(from: self) {
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM yyyy"
        outputFormatter.locale = Locale(identifier: "en_US")

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    func toPrettyDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        guard let date = formatter.date(from: self) else {
            return self
        }
        
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    func toPrettyTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        guard let date = formatter.date(from: self) else {
            return self
        }
        
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
