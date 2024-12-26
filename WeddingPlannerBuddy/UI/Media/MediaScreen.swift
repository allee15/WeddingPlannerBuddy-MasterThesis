//
//  MediaScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct MediaScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = MediaViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Media", hasBackButton: false) { }
            
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
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(weddings, id: \.id) { wedding in
                            WidgetView(title: wedding.name, icon: .icWedding) {
                                let vm = WeddingMediaViewModel(wedding: wedding)
                                navigation.push(WeddingMediaScreen(viewModel: vm).asDestination(), animated: true)
                            }
                        }
                    }.padding(.top, 24)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

#Preview {
    MediaScreen()
}
