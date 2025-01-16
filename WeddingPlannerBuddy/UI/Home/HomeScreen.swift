//
//  HomeScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Home", hasBackButton: false) { }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HomeCardView(card: viewModel.weddingCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .wedding
                    }
                    
                    HomeCardView(card: viewModel.tablesCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .guests
                    }
                    
                    HomeCardView(card: viewModel.mediaCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .media
                    }
                }.padding(.top, 20)
                    .padding(.horizontal, 16)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
    
    
}

fileprivate struct HomeCardView: View {
    let card: HomeCard
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(card.title)
                .font(.poppinsSemiBold(size: 18))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
                .underline()
            
            Text(card.description)
                .font(.poppinsRegular(size: 16))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
            
            Image(card.image)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 64)
            
            Button {
                action()
            } label: {
                HStack(spacing: 8) {
                    Text("Check it out")
                        .font(.poppinsRegular(size: 16))
                        .foregroundStyle(Color.mainBlack)
                    
                    Image(.icItemresultArrow)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.mainBlack)
                }
            }
        }.padding(.all, 20)
            .borderWithShadow(borderColor: Color.mainBlack,
                              width: 2,
                              cornerRadius: 8,
                              fillColor: Color.clear,
                              shadowColor: Color.mainBlack.opacity(0.3),
                              shadowRadius: 8,
                              x: -3,
                              y: 0)
    }
}

#Preview {
    HomeScreen()
}
