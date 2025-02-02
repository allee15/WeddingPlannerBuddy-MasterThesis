//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct FoodMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: FoodMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Food menu") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.foodMenu.antreu[0])
                }.padding(.top, 24)
                    .padding(.horizontal, 16)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
