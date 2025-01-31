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
    
    init(weddingCake: WeddingCake) {
        self.weddingCake = weddingCake
    }
    
    func editWeddingCake(_ weddingCake: WeddingCake) {
        self.weddingService.editWeddingCake(weddingCake: weddingCake)
            .sink { _ in
                
            } receiveValue: { [weak self] weddingCake in
                guard let self else {return}
                self.weddingCake = weddingCake
            }.store(in: &bag)
    }
}
