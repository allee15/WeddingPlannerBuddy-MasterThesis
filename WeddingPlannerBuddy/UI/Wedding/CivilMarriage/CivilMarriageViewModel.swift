//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class CivilMarriageViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var civilMarriage: CivilMarriage
    
    init(civilMarriage: CivilMarriage) {
        self.civilMarriage = civilMarriage
    }
    
    func editCivilMarriage(_ civilMarriage: CivilMarriage) {
        self.weddingService.editCivilMarriage(civilMarriage: civilMarriage)
            .sink { _ in
                
            } receiveValue: { [weak self] civilMarriage in
                guard let self else {return}
                self.civilMarriage = civilMarriage
            }.store(in: &bag)
    }
}
