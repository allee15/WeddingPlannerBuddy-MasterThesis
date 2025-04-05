//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class FoodMenuViewModel: BaseViewModel {
    @Published var foodMenu: FoodMenu
    
    init(foodMenu: FoodMenu) {
        self.foodMenu = foodMenu
    }
}
