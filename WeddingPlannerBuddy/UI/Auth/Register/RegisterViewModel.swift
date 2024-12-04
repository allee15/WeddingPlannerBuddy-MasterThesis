//
//  RegisterViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

class RegisterViewModel: BaseViewModel {
    private var userService = UserService.shared
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var termsAccepted: Bool = false
    @Published var termsError: String?
    
    let registerCompletion = PassthroughSubject<LoginCompletion, Never>()
    
    func allFieldsAreValid() {
        if !email.isValidEmail() {
            self.emailError = "Please enter a valid email address."
        }
        
        if password.isEmpty {
            self.passwordError = "Please enter a password."
        } else if password.count < 6 {
            self.passwordError = "Password must have at least 6 characters."
        }
        
        if !termsAccepted {
            self.termsError = "Please accept the terms and conditions."
        }
        
        if emailError == nil && passwordError == nil && termsAccepted {
            self.register()
        }
    }
    
    private func register() {
        userService.register(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.registerCompletion.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.registerCompletion.send(.login)
            }
            .store(in: &bag)
    }
}
