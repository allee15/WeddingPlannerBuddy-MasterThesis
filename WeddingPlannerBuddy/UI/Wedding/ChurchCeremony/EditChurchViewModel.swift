//
//  EditChurchViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditChurchState {
    case completed
    case error
}

class EditChurchViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var churchCeremony: ChurchCeremony
    @Published var newAddress: String = ""
    @Published var newPrice: String = ""
    @Published var newPreotName: String = ""
    @Published var newHour: Date? = nil
    @Published var newDate: Date? = nil
    
    let eventSubject = PassthroughSubject<EditChurchState, Never>()
    
    init(churchCeremony: ChurchCeremony) {
        self.churchCeremony = churchCeremony
    }
    
    func editChurch() {
        let church = ChurchCeremony(id: churchCeremony.id,
                                    churchAddress: newAddress.isEmpty ? churchCeremony.churchAddress : newAddress,
                                    date: newDate == nil ? churchCeremony.date : newDate!.description,
                                    hour: newHour == nil ? churchCeremony.hour : newHour!.description,
                                    preotName: newPreotName.isEmpty ? churchCeremony.preotName : newPreotName,
                                    price: newPrice.isEmpty ? churchCeremony.price : Int(newPrice) ?? churchCeremony.price)
        self.weddingService.editChurchCeremony(churchCeremony: church)
            .sink { _ in
                
            } receiveValue: { [weak self] churchCeremony in
                guard let self else {return}
                self.churchCeremony = churchCeremony
            }.store(in: &bag)
    }
}
