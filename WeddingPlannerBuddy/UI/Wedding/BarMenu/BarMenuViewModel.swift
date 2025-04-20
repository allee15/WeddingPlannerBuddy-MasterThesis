//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class BarMenuViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var barMenu: BarMenu
    @Published var isLoading: Bool = false
    
    init(barMenu: BarMenu) {
        self.barMenu = barMenu
    }
}
