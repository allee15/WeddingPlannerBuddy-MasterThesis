//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class PartyLocationViewModel: BaseViewModel {
    @Published var partyLocation: PartyLocation
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
    }
}
