//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI
import Kingfisher

struct WeddingDressScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingDressViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Dress",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditDressViewModel(weddingDress: viewModel.weddingDress)
                navigation.push(EditDressScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.weddingDress.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description: \(viewModel.weddingDress.description)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Text("Price: \(viewModel.weddingDress.price)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Text(.init("Link: \(viewModel.weddingDress.link)"))
                            .underline()
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                            .tint(Color.mainBlack)
                        
                        ZStack(alignment: .center) {
                            Color.nudePrimary.opacity(0.4)
                            KFImage(URL(string: viewModel.weddingDress.photo))
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 24)
                        }
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.weddingDress.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditDressViewModel(weddingDress: viewModel.weddingDress)
                        navigation.push(EditDressScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                }
            }
    }
}


