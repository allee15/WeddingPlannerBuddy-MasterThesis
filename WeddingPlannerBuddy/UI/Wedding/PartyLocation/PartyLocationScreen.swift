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
            FullNavBarView(title: "After-party",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditPartyViewModel(partyLocation: viewModel.partyLocation)
                navigation.push(EditPartyScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.partyLocation.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(viewModel.partyLocation.decorationsOrganizerDetails)")
                                    .font(.quicksandSemiBold(size: 18))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                
                                Text("📍 \(viewModel.partyLocation.partyAddress)")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("📅 \(viewModel.partyLocation.date)")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("⏰ \(viewModel.partyLocation.hour)")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("💰 \(viewModel.partyLocation.price)")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                            }
                            Spacer()
                        }
                        .padding(.all, 12)
                        .background(Color.nudePrimary.opacity(0.4))
                        .cornerRadius(4, corners: .allCorners)
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.partyLocation.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditPartyViewModel(partyLocation: viewModel.partyLocation)
                        navigation.push(EditPartyScreen(viewModel: vm).asDestination(), animated: true)
                    }
                }
            }
    }
}

