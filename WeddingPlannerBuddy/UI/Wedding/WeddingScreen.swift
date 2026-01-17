//
//  WeddingScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI
import StoreKit

struct WeddingScreen: View {
    @EnvironmentObject private var navigation: Navigation
    private let mainNavigation = EnvironmentObjects.navigation
    @StateObject private var viewModel = WeddingViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Image(.imgWeddingTab)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.container, edges: .top)
            
            VStack(spacing: 0) {
                RightNavBarView(icon: .icStatistics, title: "Your wedding") {
                    let vm = StatisticsViewModel(prices: viewModel.prices)
                    mainNavigation?.push(StatisticsScreen(viewModel: vm).asDestination(), animated: true)
                }
                
                if viewModel.isLoading {
                    Spacer()
                    HStack {
                        Spacer()
                        LoaderView()
                        Spacer()
                    }
                    Spacer()
                } else if let user = viewModel.user {
                    if user.hasActiveWedding {
                        switch viewModel.weddingDetailsState {
                        case .loading:
                            Spacer()
                            HStack {
                                Spacer()
                                LoaderView()
                                Spacer()
                            }
                            Spacer()
                        case .failure:
                            Spacer()
                            EmptyStateView(title: "An error has occured.",
                                           subtitle: "There has been an error while fetching data. Please try again later.")
                            
                            Spacer()
                            
                            MainButtonView(text: "Try again") {
                                viewModel.getUserInfo()
                            }.padding([.horizontal, .bottom], 16)
                            
                        case .value(let weddingDetails):
                            ZStack(alignment: .top) {
                                Color(hex: "#DFCEC4")
                                
                                ScrollView(showsIndicators: false) {
                                    VStack(alignment: .leading, spacing: 16) {
                                        HStack {
                                            WeddingDateAndMoneyView(date: weddingDetails.date,
                                                                    money: weddingDetails.price) {
                                                let vm = EditDateViewModel(date: weddingDetails.date,
                                                                           weddingId: weddingDetails.id)
                                                mainNavigation?.push(EditDateScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            Spacer()
                                            
                                            TimelineCardView() {
                                                mainNavigation?.push(TimelineScreen(items: viewModel.schedule,
                                                                                    weddingDate: weddingDetails.date).asDestination(),
                                                                     animated: true)
                                            }
                                        }.padding(.horizontal, 16)
                                        
                                        LazyVGrid(columns: columns, spacing: 16) {
                                            WeddingCardView(name: "Dress",
                                                            price: String(weddingDetails.weddingDress.price)) {
                                                let vm = WeddingDressViewModel(weddingDress: weddingDetails.weddingDress)
                                                mainNavigation?.push(WeddingDressScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Groom suit",
                                                            price: String(weddingDetails.groomSuit.price)) {
                                                let vm = GroomSuitViewModel(groomSuit: weddingDetails.groomSuit)
                                                mainNavigation?.push(GroomSuitScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Bouquet",
                                                            price: String(weddingDetails.bouquet.price)) {
                                                let vm = BrideBouquetViewModel(brideBouquet: weddingDetails.bouquet)
                                                mainNavigation?.push(BrideBouquetScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Legal marriage",
                                                            price: "NO PRICE") {
                                                let vm = CivilMarriageViewModel(civilMarriage: weddingDetails.civilMarriage)
                                                mainNavigation?.push(CivilMarriageScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Church marriage",
                                                            price: String(weddingDetails.churchCeremony.price)) {
                                                let vm = ChurchCeremonyViewModel(churchCeremony: weddingDetails.churchCeremony)
                                                mainNavigation?.push(ChurchCeremonyScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "After-party",
                                                            price: String(weddingDetails.partyLocation.price)) {
                                                let vm = PartyLocationViewModel(partyLocation: weddingDetails.partyLocation)
                                                mainNavigation?.push(PartyLocationScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Menu for drink",
                                                            price: String(weddingDetails.barMenu.price)) {
                                                let vm = BarMenuViewModel(barMenu: weddingDetails.barMenu)
                                                mainNavigation?.push(BarMenuScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Menu for food",
                                                            price: String(weddingDetails.foodMenu.price)) {
                                                let vm = FoodMenuViewModel(foodMenu: weddingDetails.foodMenu)
                                                mainNavigation?.push(FoodMenuScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Cake",
                                                            price: String(weddingDetails.weddingCake.price)) {
                                                let vm = WeddingCakeViewModel(weddingCake: weddingDetails.weddingCake)
                                                mainNavigation?.push(WeddingCakeScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                            WeddingCardView(name: "Band",
                                                            price: String(weddingDetails.liveBand.price)) {
                                                let vm = LiveBandViewModel(liveBand: weddingDetails.liveBand)
                                                mainNavigation?.push(LiveBandScreen(viewModel: vm).asDestination(), animated: true)
                                            }
                                            
                                        }.padding(.horizontal, 16)
                                    }.padding(.vertical, 16)
                                }
                            }.padding(.top, UIScreen.main.bounds.height / 4.25)
                                .padding(.horizontal, 16)
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
                } else {
                    UnloggedUserView()
                }
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

fileprivate struct WeddingDateAndMoneyView: View {
    let date: String
    let money: Int
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Button {
                action()
            } label: {
                HStack(spacing: 4) {
                    Image(.icCalendar)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.mainBlack)
                        .frame(width: 20, height: 20)
                    
                    Text(!date.isEmpty ? date.checkWeddingFormat() : "No date")
                        .underline()
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandSemiBold(size: 18))
                }
            }
            
            HStack(spacing: 4) {
                Image(.icMoney)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 20, height: 20)
                
                Text("\(money) RON")
                    .foregroundStyle(Color.mainBlack)
                    .font(.quicksandSemiBold(size: 18))
            }
        }
    }
}

fileprivate struct WeddingCardView: View {
    let name: String
    let price: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Spacer()
                    
                    Text(name)
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandMedium(size: 16))
                        .multilineTextAlignment(.center)
                    
                    if price != "NO PRICE" {
                        HStack(spacing: 4) {
                            Image(.icMoney)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color.mainBlack)
                                .frame(width: 20, height: 20)
                            
                            Text("\(price) RON")
                                .foregroundStyle(Color.mainBlack)
                                .font(.quicksandRegular(size: 12))
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }.background(Color.mainWhite.opacity(0.5))
                .cornerRadius(4, corners: .allCorners)
                .border(Color.greenPrimary, width: 1, cornerRadius: 4)
        }
    }
}

fileprivate struct TimelineCardView: View {
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Text("View timeline")
                    .foregroundStyle(Color.mainBlack)
                    .font(.quicksandMedium(size: 16))
                    .multilineTextAlignment(.center)
                
                Image(.icItemresultArrow)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 24, height: 24)
            }
            .padding(.all, 12)
            .background(Color.mainWhite.opacity(0.5))
            .cornerRadius(4, corners: .allCorners)
            .border(Color.greenPrimary, width: 1, cornerRadius: 4)
        }
    }
}

#Preview {
    WeddingScreen()
}
