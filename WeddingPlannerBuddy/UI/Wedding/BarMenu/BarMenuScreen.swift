//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct BarMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: BarMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Bar menu",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditBarMenuViewModel(barMenu: viewModel.barMenu)
                navigation.push(EditBarMenuScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.barMenu.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Price: \(viewModel.barMenu.price) RON")
                                .font(.quicksandMedium(size: 16))
                                .foregroundStyle(Color.mainBlack)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding(.all, 12)
                        .background(Color.nudePrimary.opacity(0.4))
                        .cornerRadius(8, corners: .allCorners)
                        
                        FoodTypeView(title: "Alcoholic drinks", food: viewModel.barMenu.alcoholic)
                        FoodTypeView(title: "Non-alcoholic drinks", food: viewModel.barMenu.nonalcoholic)
                        FoodTypeView(title: "Coffee", food: viewModel.barMenu.coffee)
                        FoodTypeView(title: "Juice", food: viewModel.barMenu.juice)
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.barMenu.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditBarMenuViewModel(barMenu: viewModel.barMenu)
                        navigation.push(EditBarMenuScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}

