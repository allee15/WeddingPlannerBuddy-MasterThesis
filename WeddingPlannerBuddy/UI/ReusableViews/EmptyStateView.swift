//
//  EmptyStateView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let subtitle: String
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(title)
                .foregroundColor(.black)
                .font(.quicksandSemiBold(size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Text(subtitle)
                .foregroundColor(.black)
                .font(.quicksandRegular(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Spacer()
        }
    }
}
