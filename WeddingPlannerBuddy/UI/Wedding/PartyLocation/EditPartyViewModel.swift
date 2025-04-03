//
//  EditPartyViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditPartyState {
    case completed
    case error
}

class EditPartyViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var partyLocation: PartyLocation
    @Published var newAddress: String = ""
    @Published var newPrice: String = ""
    @Published var newDescription: String = ""
    @Published var newHour: Date? = nil
    @Published var newDate: Date? = nil
    
    let eventSubject = PassthroughSubject<EditPartyState, Never>()
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
    }
    
    func editParty() {
        let party = PartyLocation(id: partyLocation.id.isEmpty ? UUID().uuidString : partyLocation.id,
                                  partyAddress: newAddress.isEmpty ? partyLocation.partyAddress : newAddress,
                                    date: newDate == nil ? partyLocation.date : newDate!.description,
                                    hour: newHour == nil ? partyLocation.hour : newHour!.description,
                                    decorationsOrganizerDetails: newDescription.isEmpty ? partyLocation.decorationsOrganizerDetails : newDescription,
                                    price: newPrice.isEmpty ? partyLocation.price : Int(newPrice) ?? partyLocation.price)
        self.weddingService.editPartyLocation(partyLocation: party)
            .sink { _ in
                
            } receiveValue: { [weak self] partyLocation in
                guard let self else {return}
                self.partyLocation = partyLocation
            }.store(in: &bag)
    }
}
