//
//  MainButtonView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 04.12.2024.
//

import SwiftUI

struct MainButtonView: View {
    let text: String
    var bgColor: Color = Color.greenPrimary
    var textColor: Color = Color.mainWhite
    var isDisabled: Bool = false
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                
                Text(text)
                    .font(.quicksandMedium(size: 18))
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

