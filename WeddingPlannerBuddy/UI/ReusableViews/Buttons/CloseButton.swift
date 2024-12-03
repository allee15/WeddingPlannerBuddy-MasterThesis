//
//  CloseButton.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct CloseButton: View {
    @EnvironmentObject private var navigation: Navigation
    var action: (() -> ())?
    
    var body: some View {
        Button {
            action?()
            navigation.replaceNavigationStack([TabBarScreen().asDestination()], animated: true)
        } label: {
            Image(.icNavClose)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.mainBlack)
                .frame(width: 32, height: 32)
        }
    }
}
