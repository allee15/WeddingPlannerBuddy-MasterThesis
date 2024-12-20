//
//  GuestsViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

class GuestsViewModel: BaseViewModel {
    private var userService = UserService.shared
    @Published var user: User?
    @Published var isLoading: Bool = false
    
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
                case .failure(_):
                    self.isLoading = false
                case .loading:
                    self.isLoading = true
                case .ready(let userState):
                    self.isLoading = false
                    switch userState {
                    case .anonymous:
                        self.user = nil
                    case .loggedIn(let user):
                        self.user = user
                    }
                }
            }).store(in: &bag)
    }
    
    func startWedding() {
        //TODO hasActiveWedding = true
    }
    
    func sendWeddingInvitation() {
        //TODO
    }
}
