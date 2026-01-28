//
//  ClearButton.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct ClearButton: View {
    let text: String
    var colorText: Color = Color.mainBlack
    var bgColor: Color = Color.clear
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                
                Text(text)
                    .font(.quicksandMedium(size: 16))
                    .foregroundColor(colorText)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth:.infinity)
                
                Spacer()
            }.padding(.vertical, 12)
                .background(bgColor)
                .cornerRadius(8, corners: .allCorners)
        }
    }
}
