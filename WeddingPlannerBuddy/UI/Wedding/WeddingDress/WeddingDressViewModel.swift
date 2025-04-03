//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class WeddingDressViewModel: BaseViewModel {
    @Published var weddingDress: WeddingDress
    
    init(weddingDress: WeddingDress) {
        self.weddingDress = weddingDress
    }
}
