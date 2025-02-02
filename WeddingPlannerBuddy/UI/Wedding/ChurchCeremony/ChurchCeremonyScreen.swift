//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct ChurchCeremonyScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: ChurchCeremonyViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Church ceremony") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.churchCeremony.churchAddress)
                }.padding(.top, 24)
                    .padding(.horizontal, 16)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

