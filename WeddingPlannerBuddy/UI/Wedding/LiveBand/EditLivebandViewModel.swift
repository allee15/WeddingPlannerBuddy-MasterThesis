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
    @Published var newName: String = ""
    @Published var newPrice: String = ""
    @Published var newDescription: String = ""
    @Published var newHour: Date? = nil
    @Published var newDate: Date? = nil
    
    let eventSubject = PassthroughSubject<EditLiveBandState, Never>()
    
    init(liveBand: LiveBand) {
        self.liveBand = liveBand
    }
    
    func editBand() {
        let band = LiveBand(id: liveBand.id.isEmpty ? UUID().uuidString : liveBand.id,
                            name: newName.isEmpty ? liveBand.name : newName,
                            price: newPrice.isEmpty ? liveBand.price : Int(newPrice) ?? liveBand.price,
                            hour: newHour == nil ? liveBand.hour : newHour!.description,
                            details: newDescription.isEmpty ? liveBand.details : newDescription)
        self.weddingService.editLiveBand(liveBand: band)
            .sink { _ in
                
            } receiveValue: { [weak self] liveBand in
                guard let self else {return}
                self.liveBand = liveBand
            }.store(in: &bag)
    }
}
