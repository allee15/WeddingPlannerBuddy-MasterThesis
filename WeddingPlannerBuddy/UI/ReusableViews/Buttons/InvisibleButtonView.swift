//
//  InvisibleButtonView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import SwiftUI

struct InvisibleButtonView: View {
    let text: String
    var bgColor: Color = Color.mainWhite.opacity(0.8)
    var textColor: Color = Color.mainBlack
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.quicksandMedium(size: 16))
                .foregroundColor(textColor)
                .lineLimit(1)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth:.infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(bgColor)
                .cornerRadius(4, corners: .allCorners)
        }
    }
}
