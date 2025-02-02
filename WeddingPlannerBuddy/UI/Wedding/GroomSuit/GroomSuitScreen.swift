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
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.groomSuit.description)
                }.padding(.top, 24)
                    .padding(.horizontal, 16)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

