//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI
import Kingfisher

struct BrideBouquetScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: BrideBouquetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Bouquet",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditBouquetViewModel(brideBouquet: viewModel.brideBouquet)
                navigation.push(EditBouquetScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.brideBouquet.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Description: \(viewModel.brideBouquet.description.isEmpty ? "Not specified" : viewModel.brideBouquet.description)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Text("Price: \(viewModel.brideBouquet.price)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Button {
                            if let url = URL(string: viewModel.brideBouquet.link) {
                                navigation.push(WebViewScreen(title: "Bouquet Link", url: url).asDestination(), animated: true)
                            }
                        } label: {
                            Text("Link: \(viewModel.brideBouquet.link.isEmpty ? "Not specified" : viewModel.brideBouquet.link)")
                                .underline()
                                .font(.quicksandMedium(size: 16))
                                .foregroundStyle(Color.mainBlack)
                                .tint(Color.mainBlack)
                        }
                        
                        if !viewModel.brideBouquet.photo.isEmpty {
                            ZStack(alignment: .center) {
                                Color.nudePrimary.opacity(0.4)
                                KFImage(URL(string: "http://localhost:8000/\(viewModel.brideBouquet.photo)"))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: UIScreen.main.bounds.height / 3)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 24)
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
                if viewModel.brideBouquet.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditBouquetViewModel(brideBouquet: viewModel.brideBouquet)
                        navigation.push(EditBouquetScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}
