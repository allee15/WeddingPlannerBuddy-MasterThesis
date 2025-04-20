//
//  GuestsViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import UIKit
import Combine

enum GuestsEvent {
    case errorCreatingWedding
    case completed
}

class GuestsViewModel: BaseViewModel {
    private var userService = UserService.shared
    private let weddingService = WeddingService.shared
    
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var weddingDate: String = ""
    @Published var weddingChurchLocation: String = ""
    @Published var weddingPartyLocation: String = ""
    
    let eventSubject = PassthroughSubject<GuestsEvent, Never>()
    
    override init() {
        super.init()
        self.getUserInfo()
        self.getWeddingDetails()
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
        guard let user = user else {return}
        weddingService.startWedding(userId: user.id, date: "")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(_):
                    self.eventSubject.send(.errorCreatingWedding)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    userService.userReactiveData.reload()
                    self.eventSubject.send(.completed)
                } else {
                    self.eventSubject.send(.errorCreatingWedding)
                }
            }.store(in: &bag)
    }
    
    private func getWeddingDetails() {
        guard let user = user else {return}
        self.weddingService.weddingReactiveData.getStateSubject()
            .sink { _ in
                
            } receiveValue: { [weak self] weddingDetails in
                guard let self else {return}
                
                switch weddingDetails {
                case .failure(_):
                    break
                case .loading:
                    break
                case .ready(let details):
                    self.weddingDate = details.date
                    self.weddingPartyLocation = details.partyLocation.partyAddress
                    self.weddingChurchLocation = details.churchCeremony.churchAddress
                }
            }.store(in: &bag)
    }
}
