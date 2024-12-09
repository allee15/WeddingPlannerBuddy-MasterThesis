//
//  MainButtonView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 04.12.2024.
//

import SwiftUI

struct MainButtonView: View {
    let text: String
    var isDisabled: Bool = false
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                
                Text(text)
                    .font(.poppinsSemiBold(size: 14))
                    .foregroundColor(Color.mainWhite)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth:.infinity)
                
                Spacer()
            }.padding(.vertical, 16)
                .background(Color.mainBlack)
                .cornerRadius(4, corners: .allCorners)
        }.disabled(isDisabled)
    }
}

