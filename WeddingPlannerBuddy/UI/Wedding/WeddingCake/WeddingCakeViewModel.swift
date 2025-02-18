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
    @Published var isLoading: Bool = false
    
    init(weddingCake: WeddingCake) {
        self.weddingCake = weddingCake
    }
    
    func editWeddingCake(_ weddingCake: WeddingCake) {
        self.isLoading = true
        self.weddingService.editWeddingCake(weddingCake: weddingCake)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] weddingCake in
                guard let self else {return}
                self.weddingCake = weddingCake
                self.isLoading = false
            }.store(in: &bag)
    }
}
