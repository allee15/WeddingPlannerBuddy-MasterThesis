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
    @Published var newHour = Date()
    @Published var newDate = Date()
    
    let eventSubject = PassthroughSubject<EditPartyState, Never>()
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
    }
    
    func editParty() {
        let party = PartyLocation(id: partyLocation.id.isEmpty ? UUID().uuidString : partyLocation.id,
                                  partyAddress: newAddress.isEmpty ? partyLocation.partyAddress : newAddress,
                                    date: newDate == Date() ? partyLocation.date : newDate.description,
                                    hour: newHour == Date() ? partyLocation.hour : newHour.description,
                                    decorationsOrganizerDetails: newDescription.isEmpty ? partyLocation.decorationsOrganizerDetails : newDescription,
                                    price: newPrice.isEmpty ? partyLocation.price : Int(newPrice) ?? partyLocation.price)
        self.weddingService.editPartyLocation(partyLocation: party)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] partyLocation in
                guard let self else {return}
                self.partyLocation = partyLocation
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
}
