//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct BarMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: BarMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Bar menu") {
                navigation.pop(animated: true)
            }
            
            Text(viewModel.barMenu.nonalcoholic[0])
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

