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
    
    @Published var weddingId: String
    @Published var date: String
    @Published var newDate = Date()
    
    let eventSubject = PassthroughSubject<EditDateState, Never>()
    
    init(date: String, weddingId: String) {
        self.date = date
        self.weddingId = weddingId
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        if let parsedDate = formatter.date(from: date) {
            self.newDate = parsedDate
        }
    }
    
    func editDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let formattedDate = formatter.string(from: newDate)
        
        self.weddingService.editDate(date: formattedDate, weddingId: weddingId)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    reloadWedding()
                    self.eventSubject.send(.completed)
                } else {
                    self.eventSubject.send(.error)
                }
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
