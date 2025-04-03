//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class GroomSuitViewModel: BaseViewModel {
    @Published var groomSuit: GroomSuit
    
    init(groomSuit: GroomSuit) {
        self.groomSuit = groomSuit
    }
}
