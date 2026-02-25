//
//  LoginViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

enum LoginCompletion {
    case login
    case failure(Error)
}

enum LoginField {
    case email
    case password
}

class LoginViewModel: BaseViewModel {
    private var userService = UserService.shared
    private var weddingService = WeddingService.shared
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    
    let loginCompletion = PassthroughSubject<LoginCompletion, Never>()
    
    func allFieldsAreValid() {
        if !email.isValidEmail() {
            self.emailError = "Please enter a valid email address."
        }
        
        if password.isEmpty {
            self.passwordError = "Please enter a password."
        } else if password.count < 6 {
            self.passwordError = "Password must have at least 6 characters."
        }
        
        if emailError == nil && passwordError == nil {
            self.login()
        }
    }
    
    private func login() {
        userService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.loginCompletion.send(.failure(error))
                case .finished:
                    break
                }
            } receiveValue: { [weak self] user in
                guard let self else { return }
                self.weddingService.weddingReactiveData.reload()
                self.loginCompletion.send(.login)
            }
            .store(in: &bag)
    }
}
