//
//  WeddingMediaViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit

enum AddImageCompletion {
    case added
    case failed
    case showRateModal
}

class WeddingMediaViewModel: BaseViewModel {
    private let userService = UserService.shared
    private let weddingService = WeddingService.shared
    private let userDefaultsService = UserDefaultsService.shared
    @Published var wedding: Wedding
    
    let eventSubject = PassthroughSubject<AddImageCompletion, Never>()
    
    init(wedding: Wedding) {
        self.wedding = wedding
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        
        weddingService.addImage(wedding: wedding, image: image)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    self.eventSubject.send(.added)
                    if !userDefaultsService.getShowRateModalStatus() {
                        self.eventSubject.send(.showRateModal)
                        userDefaultsService.setShowRateModal(hasShownRateModal: true)
                    }
                    userService.userReactiveData.reload()
                } else {
                    self.eventSubject.send(.failed)
                }
            }.store(in: &bag)
    }
    
    func reloadUSer() {
        userService.userReactiveData.reload()
    }
}
