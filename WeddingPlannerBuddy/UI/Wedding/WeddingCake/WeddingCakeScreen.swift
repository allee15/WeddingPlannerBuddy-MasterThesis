//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct WeddingCakeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingCakeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding cake") {
                navigation.pop(animated: true)
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    LoaderView()
                    Spacer()
                }.padding(.horizontal, 16)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.weddingCake.id)
                        Button {
                            let new = WeddingCake(id: viewModel.weddingCake.id,
                                                  name: "vredfsf",
                                                  photo: "",
                                                  description: "fesdfewsdc",
                                                  price: 45)
                            viewModel.editWeddingCake(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.weddingCake.description)
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

