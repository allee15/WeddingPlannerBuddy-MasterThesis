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
                if user.hasActiveWedding {
                    if !user.tablesAtWedding.isEmpty {
                        //TODO tine cont si de guests array
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Here is your list of guests. You can invite more people by clicking on the button below, you can also send them details about the wedding and, the most important thing, you can create a scheme for the tables.")
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Color.mainBlack)
                                    .font(.poppinsSemiBold(size: 16))
                                    .padding(.horizontal, 16)
                                
                                MainButtonView(text: "Invite more people") {
                                    //TODO send invitation via email
                                }.padding(.horizontal, 16)
                                
                                WidgetView(title: "Check tables plan", icon: .icTables) {
                                    mainNavigation?.push(TablesPlanScreen().asDestination(), animated: true)
                                }
                            }.padding(.top, 24)
                        }
                    } else {
                        //TODO start wedding button
                    }
                } else if !user.otherWeddings.isEmpty {
                    //TODO sa vezi detalii despre acele nunti
                } 
            } else {
                Text("Error. Please try again later.")
                    .foregroundStyle(Color.mainBlack)
                    .font(.poppinsRegular(size: 16))
                Spacer()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
