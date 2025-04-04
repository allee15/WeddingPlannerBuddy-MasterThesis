//
//  EditDateViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 04.04.2025.
//

import Foundation
import Combine

enum EditDateState {
    case completed
    case error
}

class EditDateViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var weddingId: Int
    @Published var date: String
    @Published var newDate = Date()
    
    let eventSubject = PassthroughSubject<EditDateState, Never>()
    
    init(date: String, weddingId: Int) {
        self.date = date
        self.weddingId = weddingId
    }
    
    func editDate() {
        self.weddingService.editDate(date: date, weddingId: weddingId)
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    self.eventSubject.send(.completed)
                } else {
                    self.eventSubject.send(.error)
                }
            }.store(in: &bag)
    }
}
