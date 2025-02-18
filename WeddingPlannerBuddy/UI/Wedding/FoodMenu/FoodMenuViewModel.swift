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
    @Published var isLoading: Bool = false
    
    init(foodMenu: FoodMenu) {
        self.foodMenu = foodMenu
    }
    
    func editFoodMenu(_ foodMenu: FoodMenu) {
        self.isLoading = true
        self.weddingService.editFoodMenu(foodMenu: foodMenu)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
                
            } receiveValue: { [weak self] foodMenu in
                guard let self else {return}
                self.foodMenu = foodMenu
                self.isLoading = false
            }.store(in: &bag)
    }
}
