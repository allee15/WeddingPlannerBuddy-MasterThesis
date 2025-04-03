//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI
//TODO: fixme
struct FoodMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: FoodMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Food menu") {
                navigation.pop(animated: true)
            }
            
            if viewModel.foodMenu.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.foodMenu.id)
                        Button {
                            let new = FoodMenu(id: viewModel.foodMenu.id,
                                               antreu: ["Antreu 1"],
                                               firstCourse: ["fwfswr"],
                                               mainCourse: ["ferwsdfs"],
                                               secondMainCourse: ["dfssdf"],
                                               price: 34)
                            viewModel.editFoodMenu(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.foodMenu.antreu[0])
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.foodMenu.id.isEmpty {
                    MainButtonView(text: "Start") {
//                        let vm = EditLegalViewModel(civilMarriage: viewModel.civilMarriage)
//                        navigation.push(EditLegalScreen(viewModel: vm).asDestination(), animated: true)
                    }
                }
            }
    }
}
