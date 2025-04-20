//
//  EditLegalViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine

enum EditLegalState {
    case completed
    case error
}

class EditLegalViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var civilMarriage: CivilMarriage
    @Published var newAddress: String = ""
    @Published var newHour = Date()
    @Published var newDate = Date()
    
    let eventSubject = PassthroughSubject<EditLegalState, Never>()
    
    init(civilMarriage: CivilMarriage) {
        self.civilMarriage = civilMarriage
    }
    
    func editLegal() {
        let civil = CivilMarriage(id: civilMarriage.id.isEmpty ? UUID().uuidString : civilMarriage.id,
                                  address: newAddress.isEmpty ? civilMarriage.address : newAddress,
                                  date: newDate == Date() ? civilMarriage.date : newDate.description,
                                  hour: newHour == Date() ? civilMarriage.hour : newHour.description)
        self.weddingService.editCivilMarriage(civilMarriage: civil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] civilMarriage in
                guard let self else {return}
                self.civilMarriage = civilMarriage
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
