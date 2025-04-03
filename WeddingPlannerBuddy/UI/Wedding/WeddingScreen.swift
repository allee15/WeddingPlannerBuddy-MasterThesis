//
//  WeddingScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI
import StoreKit
//TODO: fixme
struct WeddingScreen: View {
    @EnvironmentObject private var navigation: Navigation
    private let mainNavigation = EnvironmentObjects.navigation
    @StateObject private var viewModel = WeddingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding list", hasBackButton: false) { }
            
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
                    VStack(alignment: .leading, spacing: 12) {
                        if user.hasActiveWedding {
                            switch viewModel.weddingDetailsState {
                            case .loading:
                                HStack {
                                    Spacer()
                                    LoaderView()
                                    Spacer()
                                }.padding(.horizontal, 16)
                            case .failure:
                                HStack {
                                    Text("An error has occured, please try again.")
                                        .foregroundStyle(Color.mainBlack)
                                        .font(.poppinsRegular(size: 16))
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }.padding(.horizontal, 16)
                                
                                MainButtonView(text: "Try again") {
                                    viewModel.getWeddingDetails(userId: user.id)
                                }.padding(.horizontal, 16)
                                
                            case .value(let weddingDetails):
                                WidgetView(title: "Playlist", icon: .icItemresultArrow) {
                                    mainNavigation?.push(PlaylistScreen().asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Wedding dress", icon: .icItemresultArrow) {
                                    let vm = WeddingDressViewModel(weddingDress: weddingDetails.weddingDress)
                                    mainNavigation?.push(WeddingDressScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Bride's bouquet", icon: .icItemresultArrow) {
                                    let vm = BrideBouquetViewModel(brideBouquet: weddingDetails.bouquet)
                                    mainNavigation?.push(BrideBouquetScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Groom's suit", icon: .icItemresultArrow) {
                                    let vm = GroomSuitViewModel(groomSuit: weddingDetails.groomSuit)
                                    mainNavigation?.push(GroomSuitScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Church ceremony", icon: .icItemresultArrow) {
                                    let vm = ChurchCeremonyViewModel(churchCeremony: weddingDetails.churchCeremony)
                                    mainNavigation?.push(ChurchCeremonyScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Party location", icon: .icItemresultArrow) {
                                    let vm = PartyLocationViewModel(partyLocation: weddingDetails.partyLocation)
                                    mainNavigation?.push(PartyLocationScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Civil marriage information", icon: .icItemresultArrow) {
                                    let vm = CivilMarriageViewModel(civilMarriage: weddingDetails.civilMarriage)
                                    mainNavigation?.push(CivilMarriageScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Food menu", icon: .icItemresultArrow) {
                                    let vm = FoodMenuViewModel(foodMenu: weddingDetails.foodMenu)
                                    mainNavigation?.push(FoodMenuScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Bar menu", icon: .icItemresultArrow) {
                                    let vm = BarMenuViewModel(barMenu: weddingDetails.barMenu)
                                    mainNavigation?.push(BarMenuScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Wedding cake", icon: .icItemresultArrow) {
                                    let vm = WeddingCakeViewModel(weddingCake: weddingDetails.weddingCake)
                                    mainNavigation?.push(WeddingCakeScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Live band", icon: .icItemresultArrow) {
                                    let vm = LiveBandViewModel(liveBand: weddingDetails.liveBand)
                                    mainNavigation?.push(LiveBandScreen(viewModel: vm).asDestination(), animated: true)
                                }
                            }
                        } else {
                            Spacer()
                            EmptyStateView(title: "Let’s get this wedding started! 🎉",
                                           subtitle: "Add your wedding details and start planning the best day ever.")
                            Spacer()
                            MainButtonView(text: "Start planning") {
                                viewModel.startWedding()
                            }.padding([.horizontal, .bottom], 16)
                        }
                    }
                }
            } else {
                UnloggedUserView()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .showRatingModal:
                    if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene)
                    }
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

#Preview {
    WeddingScreen()
}
