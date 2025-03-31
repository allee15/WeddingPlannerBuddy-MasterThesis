//
//  LogoutScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import SwiftUI

struct LogoutScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = LogoutViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Logout") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Leaving so soon? Are you sure you want to log out?")
                        .font(.quicksandMedium(size: 20))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    
                    Text("Don’t worry, your progress is saved, and we’ll be here when you come back!")
                        .font(.quicksandRegular(size: 14))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    
                    Image(.imgLogout)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }.padding(.top, 20)
            }
        }
        .background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Logout") {
                    viewModel.logOut()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
    }
}

#Preview {
    LogoutScreen()
}
