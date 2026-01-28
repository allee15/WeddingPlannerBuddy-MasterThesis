//
//  EditLivebandViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditLiveBandState {
    case completed
    case error
}

class EditLivebandViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var liveBand: LiveBand
    @Published var newName: String
    @Published var newPrice: String
    @Published var newDescription: String
    @Published var newHour = Date()
    
    let eventSubject = PassthroughSubject<EditLiveBandState, Never>()
    
    init(liveBand: LiveBand) {
        self.liveBand = liveBand
        self.newName = liveBand.name
        self.newPrice = liveBand.price.description
        self.newDescription = liveBand.details
    }
    
    func editBand() {
        let band = LiveBand(id: liveBand.id.isEmpty ? UUID().uuidString : liveBand.id,
                            name: newName,
                            price: Int(newPrice) ?? liveBand.price,
                            hour: newHour == Date() ? liveBand.hour : newHour.description,
                            details: newDescription)
        self.weddingService.editLiveBand(liveBand: band)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] liveBand in
                guard let self else {return}
                self.liveBand = liveBand
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
