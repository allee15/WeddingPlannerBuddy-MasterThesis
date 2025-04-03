//
//  MediaViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

enum WeddigsState {
    case loading
    case failure(Error)
    case value([Wedding])
}

class MediaViewModel: BaseViewModel {
    private var weddingService = WeddingService.shared
    private var userService = UserService.shared
    
    @Published var weddingsState = WeddigsState.loading
    @Published var user: User?
    @Published var weddings: [Wedding] = []
    
    override init() {
        super.init()
        self.getUserInfo()
    }
    
    private func getUserInfo() {
        userService.userReactiveData.getStateSubject()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] userState in
                guard let self = self else { return }
                switch userState {
                case .failure(let error):
                    weddingsState = .failure(error)
                    break
                case .loading:
                    break
                case .ready(let userState):
                    switch userState {
                    case .anonymous:
                        self.user = nil
                        self.weddingsState = .value([])
                    case .loggedIn(let user):
                        self.user = user
                        self.weddings = user.weddings
                        self.weddingsState = .value(user.weddings)
                    }
                }
            }).store(in: &bag)
    }
}
