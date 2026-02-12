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
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Description: \(viewModel.weddingDress.description.isEmpty ? "Not specified" : viewModel.weddingDress.description)")
                                    .font(.quicksandMedium(size: 16))
                                    .foregroundStyle(Color.mainBlack)
                                
                                Text("Price: \(viewModel.weddingDress.price)")
                                    .font(.quicksandMedium(size: 16))
                                    .foregroundStyle(Color.mainBlack)
                                
                                Button {
                                    if let url = URL(string: viewModel.weddingDress.link) {
                                        navigation.push(WebViewScreen(title: "Dress Link", url: url).asDestination(), animated: true)
                                    }
                                } label: {
                                    Text("Link: \(viewModel.weddingDress.link.isEmpty ? "Not specified" : viewModel.weddingDress.link)")
                                        .underline()
                                        .font(.quicksandMedium(size: 16))
                                        .foregroundStyle(Color.mainBlack)
                                        .tint(Color.mainBlack)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            Spacer()
                        }
                        .padding(.all, 12)
                        .background(
                            Color.nudePrimary.opacity(0.4)
                                .cornerRadius(8, corners: .allCorners))
                        
                        if !viewModel.weddingDress.photo.isEmpty {
                            ZStack(alignment: .center) {
                                Color.nudePrimary.opacity(0.4)
                                    .cornerRadius(8, corners: .allCorners)
                                
                                KFImage(URL(string: viewModel.weddingDress.photo))
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
                if viewModel.weddingDress.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditDressViewModel(weddingDress: viewModel.weddingDress)
                        navigation.push(EditDressScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}


