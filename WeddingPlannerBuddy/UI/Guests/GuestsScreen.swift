//
//  GuestsScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI
//TODO: fixme
struct GuestsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = GuestsViewModel()
    private let mainNavigation = EnvironmentObjects.navigation
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Guests list", hasBackButton: false) { }
            
            if viewModel.isLoading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        LoaderView()
                        Spacer()
                    }
                    Spacer()
                }
            } else if let user = viewModel.user {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Here is your list of guests and/or weddings that you'll attend. You can invite more people by clicking on the button below, you can also send them details about the wedding and, the most important thing, you can create a scheme for the tables.")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color.mainBlack)
                            .font(.poppinsSemiBold(size: 16))
                            .padding(.horizontal, 16)
                        
                        if user.hasActiveWedding {
                            MainButtonView(text: "Invite more people") {
                                viewModel.sendWeddingInvitation()
                            }.padding(.horizontal, 16)
                            
                            WidgetView(title: "Check tables plan", icon: .icTables) {
                                let vm = TablesPlanViewModel(userId: user.id, tables: user.tablesAtWedding)
                                mainNavigation?.push(TablesPlanScreen(viewModel: vm).asDestination(), animated: true)
                            }
                            
                            WidgetView(title: "Check guests list", icon: .icGuests) {
                                let vm = GuestsListViewModel(guestsList: user.guests,
                                                             weddingDate: viewModel.weddingDate,
                                                             weddingChurchLocation: viewModel.weddingChurchLocation,
                                                             weddingPartyLocation: viewModel.weddingPartyLocation)
                                navigation.push(GuestsListScreen(viewModel: vm).asDestination(), animated: true)
                            }
                        } else {
                            MainButtonView(text: "Start wedding") {
                                viewModel.startWedding()
                            }.padding(.horizontal, 16)
                        }
                        
                        if !user.otherWeddings.isEmpty {
                            WidgetView(title: "Check other weddings", icon: .icWeddingsProfile) {
                                let vm = OtherWeddingsViewModel(otherWeddingsList: user.otherWeddings)
                                navigation.push(OtherWeddingsScreen(viewModel: vm).asDestination(), animated: true)
                            }
                        }
                    }.padding(.top, 24)
                }
            } else {
                UnloggedUserView()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .errorCreatingWedding:
                    let modal = ModalChooseOptionView(title: "Error",
                                          description: "An error has occured. Please try again.",
                                                      topButtonText: "Try again") {
                        navigation.dismissModal(animated: true, completion: nil)
                    }
                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                }
            }
    }
}
