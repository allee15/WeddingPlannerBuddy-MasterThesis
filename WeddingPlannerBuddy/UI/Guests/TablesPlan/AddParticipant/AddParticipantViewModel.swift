//
//  AddParticipantViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 11.12.2024.
//

import Foundation
import Combine

enum AddParticipantEvent {
    case completed
    case error
}

enum ProfileField {
    case name
    case email
}

class AddParticipantViewModel: BaseViewModel {
    private var tablesService = TablesService.shared
    
    @Published var name: String = ""
    @Published var email: String = ""
    
    let eventSubject = PassthroughSubject<AddParticipantEvent, Never>()
    
    func hasChanges() -> Bool {
        return !name.isEmpty && !email.isEmpty && email.isValidEmail()
    }
    
    func addParticipant() {
        let guest = Guest(id: UUID().uuidString, name: name, email: email)
        tablesService.addParticipant(participant: guest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.eventSubject.send(.error)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    eventSubject.send(.completed)
                } else {
                    eventSubject.send(.error)
                }
            }.store(in: &bag)
    }
}
