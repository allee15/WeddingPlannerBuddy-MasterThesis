//
//  GuestsViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import UIKit
import Combine

enum StartWeddingEvent {
    case completed
    case error
}

class GuestsViewModel: BaseViewModel {
    private var userService = UserService.shared
    private var guestsService = GuestsService.shared
    @Published var user: User?
    @Published var isLoading: Bool = false
    
    let eventSubject = PassthroughSubject<StartWeddingEvent, Never>()
    
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
        guestsService.startWedding()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.eventSubject.send(.error)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    eventSubject.send(.completed)
                } else {
                    eventSubject.send(.error)
                }
            }.store(in: &bag)
    }
    
    func sendWeddingInvitation() {
        let subject = "Our wedding"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //TODO: add date and location from wedding object!!!!
        let body = """
        Dear our beloved friend,
        
        Along with our parents, we are delighted to invite you to the celebration of our love.
        
        Here you have more information about the big day.
        Date:
        Location:
        
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
}
