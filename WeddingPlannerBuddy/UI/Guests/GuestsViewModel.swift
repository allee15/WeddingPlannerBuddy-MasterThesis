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
                } else {
                    self.eventSubject.send(.errorCreatingWedding)
                }
            }.store(in: &bag)
    }
    
    func sendWeddingInvitation() {
        let subject = "Our wedding"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let body = """
        Dear our beloved friend,
        
        Along with our parents, we are delighted to invite you to the celebration of our love.
        
        Here you have more information about the big day.
        Date: \(self.weddingDate)
        Church location: \(self.weddingChurchLocation)
        Party location: \(self.weddingPartyLocation)
        
        If you want to keep this information stored in one place, you can download the app "Wedding Planner Buddy".
        
        Warm regards,
        The Bride and the Groom
        """
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "mailto:?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Unable to open email client.")
        }
    }
    
    private func getWeddingDetails() {
        guard let user = user else {return}
        self.weddingService.getWeddingDetails(userId: user.id)
            .sink { _ in
                
            } receiveValue: { [weak self] weddingDetails in
                guard let self else {return}
                self.weddingDate = weddingDetails.date
                self.weddingPartyLocation = weddingDetails.partyLocation.partyAddress
                self.weddingChurchLocation = weddingDetails.churchCeremony.churchAddress
            }.store(in: &bag)
    }
}
