//
//  ResetPasswordViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 08.12.2024.
//

import Foundation
import Combine


enum ResetPasswordCompletion {
    case error
    case completed
}

enum ResetPasswordField {
    case currentPassword
}

class ResetPasswordViewModel: BaseViewModel {
    var firebaseService = FirebaseService.shared
    var userService = UserService.shared
    
    @Published var email: String = ""
    @Published var errorMessageEmail: String?
    let eventSubject = PassthroughSubject<ResetPasswordCompletion, Never>()
    
    func resetPassword() {
        if !email.isValidEmail() {
            self.errorMessageEmail = "Please enter a valid email address."
        } else {
            firebaseService.resetPassword(email: email)
                .sink { _ in
                    
                } receiveValue: { [weak self] response in
                    guard let self else {return}
                    if response {
                        self.eventSubject.send(.completed)
                    } else {
                        self.eventSubject.send(.error)
                    }
                }.store(in: &bag)
        }
    }
}
