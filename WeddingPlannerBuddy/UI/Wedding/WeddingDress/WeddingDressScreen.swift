//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct WeddingDressScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingDressViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding dress") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.weddingDress.description)
                }.padding(.top, 24)
                    .padding(.horizontal, 16)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}


