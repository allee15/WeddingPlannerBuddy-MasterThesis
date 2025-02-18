//
//  WeddingDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import Foundation
import Combine

class BarMenuViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var barMenu: BarMenu
    @Published var isLoading: Bool = false
    
    init(barMenu: BarMenu) {
        self.barMenu = barMenu
    }
    
    func editBarMenu(_ barMenu: BarMenu) {
        self.isLoading = true
        self.weddingService.editBarMenu(barMenu: barMenu)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else {return}
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self.isLoading = false
                }
            } receiveValue: { [weak self] barMenu in
                guard let self else {return}
                self.barMenu = barMenu
                self.isLoading = false
            }.store(in: &bag)
    }
}
