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
        Text("Wedding screen")
    }
}

#Preview {
    WeddingScreen()
}
