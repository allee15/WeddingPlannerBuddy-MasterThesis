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
    @Published var isLoading: Bool = false
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
    }
    
    func editPartyLocation(_ partyLocation: PartyLocation) {
        self.isLoading = true
        self.weddingService.editPartyLocation(partyLocation: partyLocation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] partyLocation in
                guard let self else {return}
                self.partyLocation = partyLocation
                self.isLoading = false
            }.store(in: &bag)
    }
}
