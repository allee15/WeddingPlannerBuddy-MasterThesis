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
    
    init(brideBouquet: Bouquet) {
        self.brideBouquet = brideBouquet
    }
    
    func editBouquet(_ brideBouquet: Bouquet) {
        self.weddingService.editBouquet(brideBouquet: brideBouquet)
            .sink { _ in
                
            } receiveValue: { [weak self] brideBouquet in
                guard let self else {return}
                self.brideBouquet = brideBouquet
            }.store(in: &bag)
    }
}
