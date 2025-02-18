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
    @Published var isLoading: Bool = false
    
    init(churchCeremony: ChurchCeremony) {
        self.churchCeremony = churchCeremony
    }
    
    func editChurchCeremony(_ churchCeremony: ChurchCeremony) {
        self.isLoading = true
        self.weddingService.editChurchCeremony(churchCeremony: churchCeremony)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] churchCeremony in
                guard let self else {return}
                self.churchCeremony = churchCeremony
                self.isLoading = false
            }.store(in: &bag)
    }
}
