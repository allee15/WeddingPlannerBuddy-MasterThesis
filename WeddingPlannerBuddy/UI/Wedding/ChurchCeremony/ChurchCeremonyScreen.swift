//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct ChurchCeremonyScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: ChurchCeremonyViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Church marriage",
                           rightButtonIcon: .icSettings) {
                navigation.pop(animated: true)
            } rightButtonAction: {
                let vm = EditChurchViewModel(churchCeremony: viewModel.churchCeremony)
                navigation.push(EditChurchScreen(viewModel: vm).asDestination(), animated: true)
            }
            
            if viewModel.churchCeremony.id.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Priest: \(viewModel.churchCeremony.preotName.isEmpty ? "Not specified" : viewModel.churchCeremony.preotName)")
                                    .font(.quicksandSemiBold(size: 18))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                
                                Text("📍 \(viewModel.churchCeremony.churchAddress.isEmpty ? "Not specified" : viewModel.churchCeremony.churchAddress)")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("📅 \(viewModel.churchCeremony.date.isEmpty ? "Not specified" : viewModel.churchCeremony.date.toPrettyDateString())")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("⏰ \(viewModel.churchCeremony.hour.isEmpty ? "Not specified" : viewModel.churchCeremony.hour.toPrettyTimeString())")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                                
                                Text("💰 \(viewModel.churchCeremony.price) RON")
                                    .font(.quicksandRegular(size: 14))
                                    .foregroundStyle(Color.mainBlack)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 8)
                            }
                            Spacer()
                        }
                        .padding(.all, 12)
                        .background(Color.nudePrimary.opacity(0.4))
                        .cornerRadius(8, corners: .allCorners)
                    }.padding(.top, 20)
                        .padding(.horizontal, 16)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.churchCeremony.id.isEmpty {
                    MainButtonView(text: "Start") {
                        let vm = EditChurchViewModel(churchCeremony: viewModel.churchCeremony)
                        navigation.push(EditChurchScreen(viewModel: vm).asDestination(), animated: true)
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
    }
}

