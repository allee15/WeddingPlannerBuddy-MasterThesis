//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class WeddingCakeViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var weddingCake: WeddingCake
    @Published var isLoading: Bool = false
    
    init(weddingCake: WeddingCake) {
        self.weddingCake = weddingCake
    }
}
