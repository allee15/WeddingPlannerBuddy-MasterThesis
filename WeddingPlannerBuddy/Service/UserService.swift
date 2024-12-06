//
//  UserService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine
import FirebaseAuth

class UserService {
    static let shared = UserService()
    private let userApi = UserApi()
    var bag = Set<AnyCancellable>()
    let userDefaultsService = UserDefaultsService.shared
    let firebaseService = FirebaseService.shared
    
    public lazy var userReactiveData = ReactiveData<UserState> { [weak self] in
        guard let self else {return nil}
        
        return Deferred {
            Future<UserState, Error> { promise in
                if self.isLoggedIn {
                    self.userApi.getUser()
                        .map { UserState.loggedIn($0) }
                        .catch { _ in Just(UserState.anonymous) }
                        .eraseToAnyPublisher()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                promise(.failure(error))
                            case .finished:
                                break
                            }
                        }, receiveValue: { userState in
                            promise(.success(userState))
                        })
                        .store(in: &self.bag)
                } else {
                    promise(.success(UserState.anonymous))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public var isLoggedIn: Bool {
        if let token = authToken, !token.isEmpty {
            return true
        }
        return false
    }
    
    var authToken: String? {
        set {
            userDefaultsService.setValue(key: UserDefaultsKeys.token, value: newValue)
        }
        get {
            return userDefaultsService.getValue(key: UserDefaultsKeys.token)
        }
    }
    
    private init() {
        if !isLoggedIn {
            self.userReactiveData.pushValue(value: .anonymous)
        }
    }
    
    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        self.firebaseService.login(email: email, password: password)
            .flatMap { token in
                self.authToken = token
                return self.getUser()
            }
            .handleEvents(receiveOutput: { [weak self] user in
                self?.userReactiveData.pushValue(value: .loggedIn(user))
            })
            .eraseToAnyPublisher()
    }
    
    func register(email: String, password: String) -> AnyPublisher<User, Error> {
        
        return self.firebaseService.register(email: email, password: password)
            .flatMap { token in
                self.authToken = token
                return self.getUser()
            }
            .handleEvents(receiveOutput: { [weak self] user in
                self?.userReactiveData.pushValue(value: .loggedIn(user))
            })
            .eraseToAnyPublisher()
    }
    
    func getUser() -> AnyPublisher<User, Error> {
        self.userApi.getUser()
            .handleEvents(receiveCompletion: { completion in
                if case .failure = completion {
                    self.userReactiveData.pushValue(value: .anonymous)
                }
            })
            .eraseToAnyPublisher()
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error during logout")
        }
        
        self.authToken?.removeAll()
        self.userReactiveData.pushValue(value: .anonymous)
        self.userDefaultsService.setValue(key: UserDefaultsKeys.token, value: nil)
    }
}
