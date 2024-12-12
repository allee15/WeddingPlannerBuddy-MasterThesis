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

class AddParticipantViewModel: BaseViewModel {
    @Published var name: String = ""
    
    let eventSubject = PassthroughSubject<AddParticipantEvent, Never>()
    
    func hasChanges() -> Bool {
        return !name.isEmpty
    }
    
    func addParticipant() {
        eventSubject.send(.completed)
    }
}
