//
//  WeddingScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct WeddingScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = WeddingViewModel()
    
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
                    VStack(alignment: .leading, spacing: 12) {
                        if user.hasActiveWedding {
                            WidgetView(title: "Wedding dress", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Bride's bouquet", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Groom's suit", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Church ceremony", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Party location", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Location decorations", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Civil marriage information", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Food menu", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Bar menu", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Wedding cake", icon: .icItemresultArrow) {
                                //TODO
                            }
                            
                            WidgetView(title: "Live band", icon: .icItemresultArrow) {
                                //TODO
                            }
                        } else {
                            MainButtonView(text: "Start wedding") {
                                viewModel.startWedding()
                            }.padding(.horizontal, 16)
                        }
                    }
                }
            } else {
                HStack {
                    Text("You have to log in in order to access the content of this tab.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.poppinsRegular(size: 16))
                    Spacer()
                }.padding(.horizontal, 16)
                    .padding(.top, 24)
                Spacer()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

#Preview {
    WeddingScreen()
}
