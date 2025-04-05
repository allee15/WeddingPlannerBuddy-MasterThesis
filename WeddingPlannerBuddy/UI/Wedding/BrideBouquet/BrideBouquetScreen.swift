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
                        Text("Description: \(viewModel.brideBouquet.description)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Text("Price: \(viewModel.brideBouquet.price)")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                        
                        Text(.init("Link: \(viewModel.brideBouquet.link)"))
                            .underline()
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                            .tint(Color.mainBlack)
                        
                        ZStack(alignment: .center) {
                            Color.nudePrimary.opacity(0.4)
                            KFImage(URL(string: viewModel.brideBouquet.photo))
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
