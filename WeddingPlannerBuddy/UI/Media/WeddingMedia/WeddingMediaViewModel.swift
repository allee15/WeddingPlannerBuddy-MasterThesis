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
    private let weddingService = WeddingService.shared
    private let userDefaultsService = UserDefaultsService.shared
    @Published var wedding: Wedding?
    
    let eventSubject = PassthroughSubject<AddImageCompletion, Never>()
    
    init(wedding: Wedding) {
        self.wedding = wedding
    }
    
    func addImage(image: UIImage?) {
        weddingService.addImage(image: image)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
//                    self.wedding?.images.removeAll { $0.id == newTable.id }
                    self.eventSubject.send(.failed)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
//                if let index = self.wedding?.images.firstIndex(where: { $0.id == newTable.label }) {
//                    self.tables[index] = result
//                }
                if result {
                    self.eventSubject.send(.added)
                    if !userDefaultsService.getShowRateModalStatus() {
                        self.eventSubject.send(.showRateModal)
                        userDefaultsService.setShowRateModal(hasShownRateModal: true)
                    }
                } else {
                    self.eventSubject.send(.failed)
                }
            }.store(in: &bag)
    }
}
