//
//  SecondaryButtonView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import SwiftUI

struct SecondaryButtonView: View {
    let text: String
    var bgColor: Color = Color.greenPrimary.opacity(0.5)
    var textColor: Color = Color.mainBlack
    var isDisabled: Bool = false
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                
                Text(text)
                    .font(.quicksandMedium(size: 16))
                    .foregroundColor(textColor)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth:.infinity)
                
                Spacer()
            }.padding(.vertical, 12)
                .background(bgColor)
                .cornerRadius(8, corners: .allCorners)
        }.disabled(isDisabled)
    }
}
