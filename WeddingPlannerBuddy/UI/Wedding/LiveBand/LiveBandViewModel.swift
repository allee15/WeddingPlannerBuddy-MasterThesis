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
    
    init(liveBand: LiveBand) {
        self.liveBand = liveBand
    }
    
    func editLiveBand(_ liveBand: LiveBand) {
        self.weddingService.editLiveBand(liveBand: liveBand)
            .sink { _ in
                
            } receiveValue: { [weak self] liveBand in
                guard let self else {return}
                self.liveBand = liveBand
            }.store(in: &bag)
    }
}
