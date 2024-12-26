//
//  WeddingMediaScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import SwiftUI

struct WeddingMediaScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingMediaViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Your weddings") {
                navigation.pop(animated: true)
            }
            
            Text("Wedding media screen")
            Spacer()
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
