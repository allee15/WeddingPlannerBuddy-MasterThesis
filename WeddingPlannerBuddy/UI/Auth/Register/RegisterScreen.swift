//
//  RegisterScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct RegisterScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        Text("Register screen")
    }
}

#Preview {
    RegisterScreen()
}
