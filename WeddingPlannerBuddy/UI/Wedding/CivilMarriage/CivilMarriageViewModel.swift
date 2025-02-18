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
    @Published var isLoading: Bool = false
    
    init(civilMarriage: CivilMarriage) {
        self.civilMarriage = civilMarriage
    }
    
    func editCivilMarriage(_ civilMarriage: CivilMarriage) {
        self.isLoading = true
        self.weddingService.editCivilMarriage(civilMarriage: civilMarriage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] civilMarriage in
                guard let self else {return}
                self.civilMarriage = civilMarriage
                self.isLoading = false
            }.store(in: &bag)
    }
}
