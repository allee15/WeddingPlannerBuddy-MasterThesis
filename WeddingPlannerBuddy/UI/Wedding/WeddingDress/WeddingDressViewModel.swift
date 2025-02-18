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
    @Published var isLoading: Bool = false
    
    init(weddingDress: WeddingDress) {
        self.weddingDress = weddingDress
    }
    
    func editWeddingDress(_ weddingDress: WeddingDress) {
        self.isLoading = true
        self.weddingService.editWeddingDress(weddingDress: weddingDress)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] weddingDress in
                guard let self else {return}
                self.isLoading = false
                self.weddingDress = weddingDress
            }.store(in: &bag)
    }
}
