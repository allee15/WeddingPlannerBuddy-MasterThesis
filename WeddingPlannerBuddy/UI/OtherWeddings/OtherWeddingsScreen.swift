//
//  OtherWeddingsScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import SwiftUI

struct OtherWeddingsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: OtherWeddingsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Weddings to attend") {
                navigation.pop(animated: true)
            }
            
            if !viewModel.otherWeddingsList.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(Array(viewModel.otherWeddingsList.enumerated()), id: \.element.id) { index, invitation in
                            WeddingInvitationLineView(invitation: invitation, counter: index + 1) {
                                let screen = ChooseFolderBottomSheetView {
                                    viewModel.openGoogleMaps(for: invitation.location)
                                } appleMapsAction: {
                                    viewModel.openAppleMaps(for: invitation.location)
                                } wazeAction: {
                                    viewModel.openWaze(for: invitation.location)
                                } uberAction: {
                                    viewModel.openUber(for: invitation.location)
                                }
                                navigation.presentPopup(screen.asDestination(), animated: true, completion: nil)
                            }
                        }
                    }.padding(.top, 20)
                }
            } else {
                EmptyStateView(title: "No events available.",
                               subtitle: "When a wedding is added, you’ll see all the details here.")
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

fileprivate struct WeddingInvitationLineView: View {
    let invitation: WeddingGuest
    let counter: Int
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(counter). \(invitation.date)")
                        .font(.quicksandSemiBold(size: 18))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                    
                    Text("📍 \(invitation.location)")
                        .font(.quicksandRegular(size: 14))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 8)
                    
                    Text("🍽️  Table: \(invitation.tableNb)")
                        .font(.quicksandRegular(size: 14))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 12)
                }
                Spacer()
            }
            .padding(.all, 12)
            .background(Color.nudePrimary.opacity(0.4))
            .cornerRadius(8, corners: .allCorners)
            .padding(.horizontal, 16)
        }
    }
}

