//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct WeddingCakeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingCakeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding cake") {
                navigation.pop(animated: true)
            }
            
            Text(viewModel.weddingCake.description)
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

