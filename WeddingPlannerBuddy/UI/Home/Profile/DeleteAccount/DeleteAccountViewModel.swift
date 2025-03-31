//
//  DeleteAccountViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 08.12.2024.
//

import Foundation
import Combine

enum DeleteAccountCompletion {
    case error
}

enum DeleteAccountField {
    case currentPassword
}

class DeleteAccountViewModel: BaseViewModel {
    var firebaseService = FirebaseService.shared
    var userService = UserService.shared
    
    @Published var actualPassword: String = ""
    @Published var errorMessagePassword: String?
    let eventSubject = PassthroughSubject<DeleteAccountCompletion, Never>()
    
    func deleteAccount() {
        if actualPassword.count < 6 {
            self.errorMessagePassword = "Password is incorrect."
        } else {
            firebaseService.deleteAccount(currentPassword: actualPassword)
                .sink { _ in
                    
                } receiveValue: { [weak self] response in
                    guard let self else {return}
                    if response {
                        userService.deleteAccount()
                    } else {
                        self.eventSubject.send(.error)
                    }
                }.store(in: &bag)
        }
    }
}
