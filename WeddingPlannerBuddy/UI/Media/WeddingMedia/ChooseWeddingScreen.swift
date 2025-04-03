//
//  ChooseWeddingScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI

struct ChooseWeddingScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: ChooseWeddingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Choose a wedding") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.weddings, id: \.id) { wedding in
                        WidgetView(title: wedding.name, icon: .icWeddingsProfile) {
                            let vm = WeddingMediaViewModel(wedding: wedding)
                            navigation.push(WeddingMediaScreen(viewModel: vm).asDestination(), animated: true)
                        }
                    }
                }.padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
