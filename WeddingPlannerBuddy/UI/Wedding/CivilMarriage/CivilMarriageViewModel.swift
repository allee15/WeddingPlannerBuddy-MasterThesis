//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class CivilMarriageViewModel: BaseViewModel {
    @Published var civilMarriage: CivilMarriage
    
    init(civilMarriage: CivilMarriage) {
        self.civilMarriage = civilMarriage
    }
}
