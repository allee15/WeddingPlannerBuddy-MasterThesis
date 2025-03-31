//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI
//TODO: fixme
struct WeddingDressScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: WeddingDressViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding dress") {
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
                        Text(viewModel.weddingDress.id)
                        Button {
                            let new = WeddingDress(id: viewModel.weddingDress.id,
                                                   link: "",
                                                   price: 23,
                                                   photo: "",
                                                   description: "sdfergs")
                            viewModel.editWeddingDress(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.weddingDress.description)
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}


