//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class LiveBandViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var liveBand: LiveBand
    @Published var isLoading: Bool = false
    
    init(liveBand: LiveBand) {
        self.liveBand = liveBand
    }
    
    func editLiveBand(_ liveBand: LiveBand) {
        self.isLoading = true
        self.weddingService.editLiveBand(liveBand: liveBand)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] liveBand in
                guard let self else {return}
                self.liveBand = liveBand
                self.isLoading = false
            }.store(in: &bag)
    }
}
