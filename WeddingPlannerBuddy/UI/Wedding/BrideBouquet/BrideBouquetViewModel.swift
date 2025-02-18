//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class BrideBouquetViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var brideBouquet: Bouquet
    @Published var isLoading: Bool = false
    
    init(brideBouquet: Bouquet) {
        self.brideBouquet = brideBouquet
    }
    
    func editBouquet(_ brideBouquet: Bouquet) {
        self.isLoading = true
        self.weddingService.editBouquet(brideBouquet: brideBouquet)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] brideBouquet in
                guard let self else {return}
                self.isLoading = false
                self.brideBouquet = brideBouquet
            }.store(in: &bag)
    }
}
