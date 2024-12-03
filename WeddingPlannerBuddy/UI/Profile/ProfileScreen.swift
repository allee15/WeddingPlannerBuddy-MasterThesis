//
//  ProfileScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        Text("Profile screen")
    }
}

#Preview {
    ProfileScreen()
}
