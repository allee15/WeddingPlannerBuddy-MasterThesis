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
}

class WeddingViewModel: BaseViewModel {
    private var userService = UserService.shared
    private var guestsService = GuestsService.shared
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
        guestsService.startWedding()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    userService.userReactiveData.reload()
                    self.getWeddingDetails()
                    if !userDefaultsService.getShowRateModalStatus() {
                        self.eventSubject.send(.showRatingModal)
                        userDefaultsService.setShowRateModal(hasShownRateModal: true)
                    }
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
