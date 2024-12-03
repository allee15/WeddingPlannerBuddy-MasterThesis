//
//  LoginScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        Text("Login screen")
    }
}

#Preview {
    LoginScreen()
}
