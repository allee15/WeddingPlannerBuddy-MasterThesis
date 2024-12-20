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
    @Published var name: String = ""
    @Published var email: String = ""
    
    let eventSubject = PassthroughSubject<AddParticipantEvent, Never>()
    
    func hasChanges() -> Bool {
        return !name.isEmpty
    }
    
    func addParticipant() {
        eventSubject.send(.completed)
    }
}
