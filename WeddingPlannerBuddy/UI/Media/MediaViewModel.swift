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
    
    @Published var weddingsState = WeddigsState.value(weddingsMocked) 
    @Published var user: User?
    
    override init() {
        super.init()
        self.getUserInfo()
        self.getWeddings()
    }
    
    private func getUserInfo() {
        userService.userReactiveData.getStateSubject()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] userState in
                guard let self = self else { return }
                switch userState {
                case .failure(_):
                    break
                case .loading:
                    break
                case .ready(let userState):
                    switch userState {
                    case .anonymous:
                        self.user = nil
                    case .loggedIn(let user):
                        self.user = user
                    }
                }
            }).store(in: &bag)
    }
    
    func getWeddings() {
        guard let user = user else {return}
        weddingsState = .loading
        weddingService.getWeddings(userId: user.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .failure(let error):
                    self.weddingsState = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] weddings in
                guard let self else {return}
                self.weddingsState = .value(weddings)
            }.store(in: &bag)
    }
}
