//
//  GuestsScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct GuestsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = GuestsViewModel()
    private let mainNavigation = EnvironmentObjects.navigation
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Guests", hasBackButton: false) { }
            
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
                if user.hasActiveWedding {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            Text("Here’s your list of guests and weddings you’ll be attending. Easily invite more people using the button below, share important wedding details, and—most importantly—create the perfect seating arrangement for a seamless celebration! 🎉💍")
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.mainBlack)
                                .font(.quicksandRegular(size: 16))
                                .padding(.horizontal, 16)
                            
                            HStack(spacing: 16) {
                                GuestsTabWidgetView(name: "View tables plan",
                                                    icon: .icChair) {
                                    let vm = TablesPlanViewModel(userId: user.id, tables: user.tablesAtWedding)
                                    mainNavigation?.push(TablesPlanScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                GuestsTabWidgetView(name: "View guests list",
                                                    icon: .icGuestsList) {
                                    let vm = GuestsListViewModel(guestsList: user.guests,
                                                                 weddingDate: viewModel.weddingDate,
                                                                 weddingChurchLocation: viewModel.weddingChurchLocation,
                                                                 weddingPartyLocation: viewModel.weddingPartyLocation)
                                    mainNavigation?.push(GuestsListScreen(viewModel: vm).asDestination(), animated: true)
                                }
                            }
                        }.padding(.top, 24)
                    }
                } else {
                    Spacer()
                    EmptyStateView(title: "Let’s get this wedding started! 🎉",
                                   subtitle: "Add your wedding details and start planning the best day ever.")
                    Spacer()
                }
                
            } else {
                UnloggedUserView()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    TabBarCoordinator.instance.tabBarNavigation = .wedding
                    
                case .errorCreatingWedding:
                    let modal = ModalChooseOptionView(title: "Error",
                                                      description: "An error has occured. Please try again.",
                                                      topButtonText: "Try again") {
                        navigation.dismissModal(animated: true, completion: nil)
                    }
                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                }
            }
            .safeAreaInset(edge: .bottom) {
                if let user = viewModel.user {
                    if !user.hasActiveWedding {
                        MainButtonView(text: "Start planning") {
                            viewModel.startWedding()
                        }.padding(.horizontal, 16)
                            .padding(.bottom, 8)
                    } else if !user.otherWeddings.isEmpty {
                        MainButtonView(text: "Check other weddings") {
                            let vm = OtherWeddingsViewModel(otherWeddingsList: user.otherWeddings)
                            navigation.push(OtherWeddingsScreen(viewModel: vm).asDestination(), animated: true)
                        }.padding(.horizontal, 16)
                            .padding(.bottom, 8)
                    }
                }
            }
    }
}

fileprivate struct GuestsTabWidgetView: View {
    let name: String
    let icon: ImageResource
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Spacer()
                HStack(spacing: 4) {
                    Spacer()
                    Image(icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.mainBlack)
                        .frame(width: 20, height: 20)
                    
                    Text(name)
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandMedium(size: 16))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color.greenPrimary.opacity(0.5))
        .cornerRadius(4, corners: .allCorners)
        .frame(width: (UIScreen.main.bounds.width - 32 - 16) / 2,
               height: (UIScreen.main.bounds.width - 32 - 16) / 2)
    }
}
