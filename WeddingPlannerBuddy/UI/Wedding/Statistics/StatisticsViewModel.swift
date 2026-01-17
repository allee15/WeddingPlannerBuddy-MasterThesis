//
//  StatisticsViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 17.01.2026.
//

import Foundation

class StatisticsViewModel: BaseViewModel {
    @Published var prices: [PriceItem]
    
    init(prices: [PriceItem]) {
        self.prices = prices
    }
    
    func getTotalPrice() -> Int {
        prices.reduce(0) { $0 + $1.price }
    }
}
