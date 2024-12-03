//
//  HomeScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        Text("Home screen")
    }
}

#Preview {
    HomeScreen()
}
