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
                    Spacer()
                    EmptyStateView(title: "An error has occured.",
                                   subtitle: "There has been an error while fetching data. Please try again later.")
                    Spacer()
                case .value(let weddings):
                    VStack(alignment: .leading) {
                        Text("Capture the magic!")
                            .foregroundStyle(Color.mainBlack)
                            .font(.quicksandBold(size: 18))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 12)
                            .padding(.horizontal, 16)
                        
                        Text("Every love story deserves to be told. Choose your wedding and start adding unforgettable memories! 💍💖")
                            .foregroundStyle(Color.mainBlack)
                            .font(.quicksandMedium(size: 16))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 36)
                            .padding(.horizontal, 16)
                        
                        Image(.imgMedia)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.width)
                        
                        Spacer()
                    }.padding(.top, 20)
                }
            } else {
                UnloggedUserView()
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                MainButtonView(text: "Select wedding") {
                    let vm = ChooseWeddingViewModel(weddings: viewModel.weddings)
                    mainNavigation?.push(ChooseWeddingScreen(viewModel: vm).asDestination(), animated: true)
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            }
    }
}

#Preview {
    MediaScreen()
}
