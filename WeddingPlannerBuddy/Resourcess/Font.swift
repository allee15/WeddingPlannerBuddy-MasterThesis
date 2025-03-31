//
//  Font.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import SwiftUI

fileprivate enum QuicksandFontNames: String {
    case bold = "Quicksand-Bold"
    case semiBold = "Quicksand-SemiBold"
    case regular = "Quicksand-Regular"
    case light = "Quicksand-Light"
    case medium = "Quicksand-Medium"
}

extension Font {
    static func quicksandBold(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.bold.rawValue, size: size)
    }
    
    static func quicksandRegular(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.regular.rawValue, size: size)
    }
        
    static func quicksandSemiBold(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.semiBold.rawValue, size: size)
    }
    
    static func quicksandLight(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.light.rawValue, size: size)
    }
    
    static func quicksandMedium(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.medium.rawValue, size: size)
    }
    
    //TODO: fixme
    
    static func poppinsBold(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.bold.rawValue, size: size)
    }
    
    static func poppinsRegular(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.regular.rawValue, size: size)
    }
        
    static func poppinsSemiBold(size: CGFloat) -> Font {
        return Font.custom(QuicksandFontNames.semiBold.rawValue, size: size)
    }
}
