//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI
import Kingfisher

struct WeddingCakeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingCakeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Cake",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditCakeViewModel(weddingCake: viewModel.weddingCake)
                navigation.push(EditCakeScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.weddingCake.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Name: \(viewModel.weddingCake.name.isEmpty ? "Not specified" : viewModel.weddingCake.name)")
                                    .font(.quicksandSemiBold(size: 16))
                                    .foregroundStyle(Color.mainBlack)
                                
                                Text("Description: \(viewModel.weddingCake.description.isEmpty ? "Not specified" : viewModel.weddingCake.description)")
                                    .font(.quicksandMedium(size: 16))
                                    .foregroundStyle(Color.mainBlack)
                                
                                Text("Price: \(viewModel.weddingCake.price) RON")
                                    .font(.quicksandMedium(size: 16))
                                    .foregroundStyle(Color.mainBlack)
                            }
                            Spacer()
                        }
                        .padding(.all, 12)
                        .background(
                            Color.nudePrimary.opacity(0.4)
                                .cornerRadius(8, corners: .allCorners))
                        
                        if !viewModel.weddingCake.photo.isEmpty {
                            ZStack(alignment: .center) {
                                Color.nudePrimary.opacity(0.4)
                                    .cornerRadius(8, corners: .allCorners)
                                
                                KFImage(URL(string: "http://localhost:8000/\(viewModel.weddingCake.photo)"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: UIScreen.main.bounds.height / 3)
                                    .padding(.all, 12)
                            }
                        }
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.weddingCake.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditCakeViewModel(weddingCake: viewModel.weddingCake)
                        navigation.push(EditCakeScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}

