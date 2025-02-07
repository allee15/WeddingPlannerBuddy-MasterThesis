//
//  WeddingViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Combine
import Foundation

enum WeddingDetailsState {
    case loading
    case failure
    case value(WeddingDetails)
}

enum WeddingEvent {
    case showRatingModal
    case errorCreatingWedding
}

class WeddingViewModel: BaseViewModel {
    private var userService = UserService.shared
    private let weddingService = WeddingService.shared
    private let userDefaultsService = UserDefaultsService.shared
    
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var weddingDetailsState: WeddingDetailsState = .loading
    
    let eventSubject = PassthroughSubject<WeddingEvent, Never>()
    
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
        weddingService.startWedding(userId: user.id)
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
                    self.getWeddingDetails()
                    if !userDefaultsService.getShowRateModalStatus() {
                        self.eventSubject.send(.showRatingModal)
                        userDefaultsService.setShowRateModal(hasShownRateModal: true)
                    }
                } else {
                    self.eventSubject.send(.errorCreatingWedding)
                }
            }.store(in: &bag)
    }
    
    func getWeddingDetails() {
        self.weddingDetailsState = .loading
        self.weddingService.getWeddingDetails()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.weddingDetailsState = .failure
                default:
                    break
                }
            } receiveValue: { [weak self] weddingDetails in
                guard let self else {return}
                self.weddingDetailsState = .value(weddingDetails)
            }.store(in: &bag)
    }
}
