//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct PartyLocationScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: PartyLocationViewModel
    
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
                        Text(viewModel.partyLocation.id)
                        Button {
                            let new = PartyLocation(id: viewModel.partyLocation.id,
                                                    partyAddress: "vddfv",
                                                    date: "23r3w",
                                                    hour: "12:34",
                                                    decorationsOrganizerDetails: "fecrsgtferwsdferws",
                                                    price: 34)
                            viewModel.editPartyLocation(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.partyLocation.decorationsOrganizerDetails)
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

