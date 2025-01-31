//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class FoodMenuViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var foodMenu: FoodMenu
    
    init(foodMenu: FoodMenu) {
        self.foodMenu = foodMenu
    }
    
    func editFoodMenu(_ foodMenu: FoodMenu) {
        self.weddingService.editFoodMenu(foodMenu: foodMenu)
            .sink { _ in
                
            } receiveValue: { [weak self] foodMenu in
                guard let self else {return}
                self.foodMenu = foodMenu
            }.store(in: &bag)
    }
}
