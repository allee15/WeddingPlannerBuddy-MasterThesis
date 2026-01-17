//
//  StatisticsScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 17.01.2026.
//

import SwiftUI

struct StatisticsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: StatisticsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Your budget") {
                navigation.pop(animated: true)
            }
            
            if viewModel.prices.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        TotalExpensesView(prices: viewModel.prices)
                        
                        VStack(spacing: 10) {
                            ForEach(viewModel.prices, id: \.name) { item in
                                ExpenseCardView(item: item, total: viewModel.getTotalPrice())
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .background(Color.bgSecondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

