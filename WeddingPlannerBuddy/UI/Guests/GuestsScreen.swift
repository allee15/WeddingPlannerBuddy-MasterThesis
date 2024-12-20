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
    @State var showOtherWeddingsBottomSheet: Bool = false
    @State var showGuestBottomSheet: Bool = false
    
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
                            if !user.tablesAtWedding.isEmpty {
                                MainButtonView(text: "Invite more people") {
                                    viewModel.sendWeddingInvitation()
                                }.padding(.horizontal, 16)
                                
                                WidgetView(title: "Check tables plan", icon: .icTables) {
                                    let vm = TablesPlanViewModel(tables: user.tablesAtWedding)
                                    mainNavigation?.push(TablesPlanScreen(viewModel: vm).asDestination(), animated: true)
                                }
                                
                                WidgetView(title: "Check guests list", icon: .icGuests) {
                                    self.showGuestBottomSheet = true
                                }.sheet(isPresented: $showGuestBottomSheet) {
                                    //TODO check guests list
                                }
                            } else {
                                MainButtonView(text: "Start planning") {
                                    let vm = TablesPlanViewModel(tables: user.tablesAtWedding)
                                    mainNavigation?.push(TablesPlanScreen(viewModel: vm).asDestination(), animated: true)
                                }.padding(.horizontal, 16)
                            }
                        } else {
                            MainButtonView(text: "Start wedding") {
                                viewModel.startWedding()
                            }.padding(.horizontal, 16)
                        }
                        
                        if !user.otherWeddings.isEmpty {
                            WidgetView(title: "Check other weddings", icon: .icWeddingsProfile) {
                                self.showOtherWeddingsBottomSheet = true
                            }.sheet(isPresented: $showOtherWeddingsBottomSheet) {
                                //TODO check other weddings
                            }
                        }
                    }.padding(.top, 24)
                }
            } else {
                Text("You have to log in in order to access the content of this tab.")
                    .foregroundStyle(Color.mainBlack)
                    .font(.poppinsRegular(size: 16))
                Spacer()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
