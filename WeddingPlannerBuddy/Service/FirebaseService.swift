//
//  FirebaseService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 06.12.2024.
//

import Foundation
import Combine
import FirebaseAuth

enum FirebaseError: Error {
    case login
    
    var errorDescription: String? {
        switch self {
        case .login:
            return "Password is incorect."
        }
    }
}

class FirebaseService {
    static let shared = FirebaseService()
    var bag = Set<AnyCancellable>()
    
    func register(email: String, password: String) -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error {
                    promise(.failure(error))
                }
                guard let result else {
                    promise(.failure(FirebaseError.login))
                    return
                }
                promise(.success(result.user.uid))
//                result.user.getIDToken { token, error in
//                    if let error {
//                        promise(.failure(error))
//                    }
//                    guard let token else {
//                        promise(.failure(FirebaseError.login))
//                        return
//                    }
//                    promise(.success(token))
//                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<String, Error> {
        return Future<String, Error> { promise in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error {
                    promise(.failure(error))
                } else {
                    guard let result else {
                        promise(.failure(FirebaseError.login))
                        return
                    }
                    promise(.success(result.user.uid))
//                    result.user.getIDToken { token, error in
//                        if let error {
//                            promise(.failure(error))
//                        } else {
//                            guard let token else {
//                                promise(.failure(FirebaseError.login))
//                                return
//                            }
//                            promise(.success(token))
//                        }
//                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func changePassword(currentPassword: String, newPassword: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            guard let user = Auth.auth().currentUser, let email = user.email else {
                promise(.failure(NSError(domain: "NoUser", code: 404, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found"])))
                return
            }

            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    user.updatePassword(to: newPassword) { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(true))
                        }
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func resetPassword(email: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(true))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteAccount(currentPassword: String) -> AnyPublisher<Bool, Error> {
        Future<Bool, Error> { promise in
            guard let user = Auth.auth().currentUser, let email = user.email else {
                promise(.failure(NSError(domain: "NoUser", code: 404, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found"])))
                return
            }

            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    user.delete { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(true))
                        }
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func reauthenticateUser(password: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            guard let user = Auth.auth().currentUser, let email = user.email else {
                promise(.failure(NSError(domain: "NoUser", code: 404, userInfo: [NSLocalizedDescriptionKey: "No authenticated user found or no email available."])))
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
