//
//  MediaScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct MediaScreen: View {
    @EnvironmentObject private var navigation: Navigation
    private let mainNavigation = EnvironmentObjects.navigation
    @StateObject private var viewModel = MediaViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Media", hasBackButton: false) { }
            
            if viewModel.user != nil {
                switch viewModel.weddingsState {
                case .loading:
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            LoaderView()
                            Spacer()
                        }
                        Spacer()
                    }
                case .failure(_):
                    HStack {
                        Text("You have to log in in order to access the content of this tab.")
                            .foregroundStyle(Color.mainBlack)
                            .font(.poppinsRegular(size: 16))
                        Spacer()
                    }.padding(.horizontal, 16)
                        .padding(.top, 24)
                    Spacer()
                case .value(let weddings):
                    ScrollView(showsIndicators: false) {
                        Text("Select a wedding for which you want to add memories from your gallery.")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(Color.mainBlack)
                            .font(.poppinsSemiBold(size: 16))
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(weddings, id: \.id) { wedding in
                                WidgetView(title: wedding.name, icon: .icWedding) {
                                    let vm = WeddingMediaViewModel(wedding: wedding)
                                    mainNavigation?.push(WeddingMediaScreen(viewModel: vm).asDestination(), animated: true)
                                }
                            }
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
    MediaScreen()
}
