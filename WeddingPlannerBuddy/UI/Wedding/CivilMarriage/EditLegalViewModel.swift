//
//  EditLegalViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine

class EditLegalViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var civilMarriage: CivilMarriage
    @Published var newAddress: String = ""
    @Published var newHour: Date? = nil
    @Published var newDate: Date? = nil
    
    let eventSubject = PassthroughSubject<EditPartyState, Never>()
    
    init(civilMarriage: CivilMarriage) {
        self.civilMarriage = civilMarriage
    }
    
    func editLegal() {
        let civil = CivilMarriage(id: civilMarriage.id.isEmpty ? UUID().uuidString : civilMarriage.id,
                                  address: newAddress.isEmpty ? civilMarriage.address : newAddress,
                                  date: newDate == nil ? civilMarriage.date : newDate!.description,
                                  hour: newHour == nil ? civilMarriage.hour : newHour!.description)
        self.weddingService.editCivilMarriage(civilMarriage: civil)
            .sink { _ in
                
            } receiveValue: { [weak self] civilMarriage in
                guard let self else {return}
                self.civilMarriage = civilMarriage
            }.store(in: &bag)
    }
}
