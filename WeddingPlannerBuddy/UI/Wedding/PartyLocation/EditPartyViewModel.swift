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
    @Published var newAddress: String
    @Published var newPrice: String
    @Published var newDescription: String
    @Published var newHour = Date()
    @Published var newDate = Date()
    
    let eventSubject = PassthroughSubject<EditPartyState, Never>()
    
    init(partyLocation: PartyLocation) {
        self.partyLocation = partyLocation
        self.newAddress = partyLocation.partyAddress
        self.newPrice = partyLocation.price.description
        self.newDescription = partyLocation.decorationsOrganizerDetails
    }
    
    func editParty() {
        let party = PartyLocation(id: partyLocation.id.isEmpty ? UUID().uuidString : partyLocation.id,
                                  partyAddress: newAddress,
                                  date: newDate == Date() ? partyLocation.date : newDate.description,
                                  hour: newHour == Date() ? partyLocation.hour : newHour.description,
                                  decorationsOrganizerDetails: newDescription,
                                  price: Int(newPrice) ?? partyLocation.price)
        self.weddingService.editPartyLocation(partyLocation: party)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] partyLocation in
                guard let self else {return}
                self.partyLocation = partyLocation
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
