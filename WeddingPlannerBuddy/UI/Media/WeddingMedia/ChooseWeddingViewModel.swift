//
//  ChooseWeddingViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine

class ChooseWeddingViewModel: BaseViewModel {
    @Published var weddings: [Wedding]
    
    init(weddings: [Wedding]) {
        self.weddings = weddings
    }
}
