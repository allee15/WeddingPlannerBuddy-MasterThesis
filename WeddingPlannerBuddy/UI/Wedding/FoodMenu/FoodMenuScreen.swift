//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct FoodMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: FoodMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Food menu",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditFoodMenuViewModel(foodMenu: viewModel.foodMenu)
                navigation.push(EditFoodMenuScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.foodMenu.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Price: \(viewModel.foodMenu.price)")
                                .font(.quicksandMedium(size: 16))
                                .foregroundStyle(Color.mainBlack)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        
                        FoodTypeView(title: "Entryway", food: viewModel.foodMenu.antreu)
                        FoodTypeView(title: "First course", food: viewModel.foodMenu.firstCourse)
                        FoodTypeView(title: "Main course", food: viewModel.foodMenu.mainCourse)
                        FoodTypeView(title: "Second course", food: viewModel.foodMenu.secondMainCourse)
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.foodMenu.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditFoodMenuViewModel(foodMenu: viewModel.foodMenu)
                        navigation.push(EditFoodMenuScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}
