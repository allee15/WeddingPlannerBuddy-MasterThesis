//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct GroomSuitScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: GroomSuitViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Groom's suit") {
                navigation.pop(animated: true)
            }
            
            Text(viewModel.groomSuit.description)
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

