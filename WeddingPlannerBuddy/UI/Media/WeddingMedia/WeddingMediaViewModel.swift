//
//  WeddingMediaViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine

class WeddingMediaViewModel: BaseViewModel {
    @Published var wedding: Wedding?
    
    init(wedding: Wedding) {
        self.wedding = wedding
        super.init()
        self.getWeddingMedia()
    }
    
    func getWeddingMedia() {
        //TODO
    }
}
