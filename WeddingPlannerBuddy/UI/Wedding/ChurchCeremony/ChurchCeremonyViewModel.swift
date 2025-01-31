//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class ChurchCeremonyViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var churchCeremony: ChurchCeremony
    
    init(churchCeremony: ChurchCeremony) {
        self.churchCeremony = churchCeremony
    }
    
    func editChurchCeremony(_ churchCeremony: ChurchCeremony) {
        self.weddingService.editChurchCeremony(churchCeremony: churchCeremony)
            .sink { _ in
                
            } receiveValue: { [weak self] churchCeremony in
                guard let self else {return}
                self.churchCeremony = churchCeremony
            }.store(in: &bag)
    }
}
