//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class WeddingDressViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var weddingDress: WeddingDress
    
    init(weddingDress: WeddingDress) {
        self.weddingDress = weddingDress
    }
    
    func editWeddingDress(_ weddingDress: WeddingDress) {
        self.weddingService.editWeddingDress(weddingDress: weddingDress)
            .sink { _ in
                
            } receiveValue: { [weak self] weddingDress in
                guard let self else {return}
                self.weddingDress = weddingDress
            }.store(in: &bag)
    }
}
