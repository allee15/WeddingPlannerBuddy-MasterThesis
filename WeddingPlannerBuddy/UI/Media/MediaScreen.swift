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
        Text("Media screen")
    }
}

#Preview {
    MediaScreen()
}
