//
//  UnloggedUserView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct UnloggedUserView: View {
    private let mainNavigation = EnvironmentObjects.navigation
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("You're not logged in.")
                .foregroundColor(.black)
                .font(.quicksandSemiBold(size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Text("Sign in to access your wedding plans\nand details.")
                .foregroundColor(.black)
                .font(.quicksandRegular(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainWhite)
            .safeAreaInset(edge: .bottom) {
                MainButtonView(text: "Login") {
                    mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                }.padding(.horizontal, 16)
                    .padding(.bottom, MainTabBarReservedSpace)
            }
    }
}
