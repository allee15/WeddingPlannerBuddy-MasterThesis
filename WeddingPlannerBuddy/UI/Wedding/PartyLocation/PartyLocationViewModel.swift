//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class PartyLocationViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var partyLocation: PartyLocation
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
    }
    
    func editPartyLocation(_ partyLocation: PartyLocation) {
        self.weddingService.editPartyLocation(partyLocation: partyLocation)
            .sink { _ in
                
            } receiveValue: { [weak self] partyLocation in
                guard let self else {return}
                self.partyLocation = partyLocation
            }.store(in: &bag)
    }
}
