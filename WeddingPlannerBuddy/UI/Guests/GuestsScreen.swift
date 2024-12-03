//
//  GuestsScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct GuestsScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = GuestsViewModel()
    
    var body: some View {
        Text("Guests screen")
    }
}

#Preview {
    GuestsScreen()
}
