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
            LeftNavBarView(title: "Weddings you'll attend") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    if !viewModel.otherWeddingsList.isEmpty {
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
                    } else {
                        HStack {
                            Text("You do not have any wedding invitations coming for the moment.")
                                .foregroundStyle(Color.mainBlack)
                                .font(.poppinsRegular(size: 16))
                                .padding(.horizontal, 16)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }.padding(.top, 32)
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
            VStack(alignment: .leading, spacing: 8) {
                Text("\(counter). \(invitation.date), location: \(invitation.location), table: \(invitation.tableNb)")
                    .font(.poppinsRegular(size: 16))
                    .foregroundStyle(Color.mainBlack)
                    .multilineTextAlignment(.leading)
                
                DividerView()
            }.padding(.horizontal, 16)
        }
    }
}

