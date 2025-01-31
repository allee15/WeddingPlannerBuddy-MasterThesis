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
    
    init(barMenu: BarMenu) {
        self.barMenu = barMenu
    }
    
    func editBarMenu(_ barMenu: BarMenu) {
        self.weddingService.editBarMenu(barMenu: barMenu)
            .sink { _ in
                
            } receiveValue: { [weak self] barMenu in
                guard let self else {return}
                self.barMenu = barMenu
            }.store(in: &bag)
    }
}
