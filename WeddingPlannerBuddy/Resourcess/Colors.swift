//
//  Colors.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let nudePrimary = Color(hex: "#C2A797")
    static let nudeSecondary = Color(hex: "#AB9A7E")
    static let nudeGreen = Color(hex: "#8E8E6B")
    static let greenPrimary = Color(hex: "#6D835F")
    static let greenSecondary = Color(hex: "#45775B")
    static let greenTertiary = Color(hex: "#046B5E")
    
    static let mainBlack = Color(hex: "#23201E")
    static let mainWhite = Color(hex: "#FFFFFF")
    
    static let lightGreen = Color(hex: "#DCF7EF")
    static let lightRed = Color(hex: "#EFD0D0")
    static let darkRed = Color(hex: "#B21010")
    
    static let mainPink = Color(hex: "#d75c77")
    
    static let bottomSheetLine = Color(hex: "#D5D6D8")
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(red: 0, green: 0, blue: 0, opacity: 0)
            return
        }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            self.init(red: 0, green: 0, blue: 0, opacity: 0)
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
