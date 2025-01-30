//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct PartyLocationScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = PartyLocationViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding dress") {
                navigation.pop(animated: true)
            }
            
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

#Preview {
    PartyLocationScreen()
}
