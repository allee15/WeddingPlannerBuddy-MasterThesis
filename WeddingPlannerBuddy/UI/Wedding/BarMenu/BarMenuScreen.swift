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
            LeftNavBarView(title: "Bar menu") {
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
                        Text(viewModel.barMenu.id)
                        Button {
                            let new = BarMenu(id: viewModel.barMenu.id,
                                              alcoholic: ["ewdsfer"],
                                              nonalcoholic: ["fsdersdfc"],
                                              coffee: ["fersdf"],
                                              juice: ["fersdf"],
                                              price: 34)
                            viewModel.editBarMenu(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.barMenu.nonalcoholic[0])
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

