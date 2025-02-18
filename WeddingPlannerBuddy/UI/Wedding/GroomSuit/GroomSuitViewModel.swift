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
    @Published var isLoading: Bool = false
    
    init(groomSuit: GroomSuit) {
        self.groomSuit = groomSuit
    }
    
    func editGroomSuit(_ groomSuit: GroomSuit) {
        self.isLoading = true
        self.weddingService.editGroomSuit(groomSuit: groomSuit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] groomSuit in
                guard let self else {return}
                self.groomSuit = groomSuit
                self.isLoading = false
            }.store(in: &bag)
    }
}
