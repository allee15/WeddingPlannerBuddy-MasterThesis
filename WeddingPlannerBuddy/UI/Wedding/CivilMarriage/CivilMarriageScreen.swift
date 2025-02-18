//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct CivilMarriageScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: CivilMarriageViewModel
    
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
                        Text(viewModel.civilMarriage.id)
                        Button {
                            let new = CivilMarriage(id: viewModel.civilMarriage.id,
                                                    address: "cefsgdersfgfersfd",
                                                    date: "12.23",
                                                    hour: "12:45")
                            viewModel.editCivilMarriage(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.civilMarriage.address)
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
