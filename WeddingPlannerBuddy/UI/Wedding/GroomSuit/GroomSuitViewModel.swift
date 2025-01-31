//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class GroomSuitViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var groomSuit: GroomSuit
    
    init(groomSuit: GroomSuit) {
        self.groomSuit = groomSuit
    }
    
    func editGroomSuit(_ groomSuit: GroomSuit) {
        self.weddingService.editGroomSuit(groomSuit: groomSuit)
            .sink { _ in
                
            } receiveValue: { [weak self] groomSuit in
                guard let self else {return}
                self.groomSuit = groomSuit
            }.store(in: &bag)
    }
}
