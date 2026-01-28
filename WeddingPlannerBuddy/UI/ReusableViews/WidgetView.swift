//
//  WidgetView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import SwiftUI

struct WidgetView: View {
    let title: String
    let icon: ImageResource
    var showToggle: Bool = true
    var hasBg: Bool = true
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.quicksandSemiBold(size: 16))
                    .foregroundColor(.mainBlack)
                
                Spacer()
                
                if showToggle {
                    Image(.icItemresultArrow)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.mainBlack)
                }
            }.padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(hasBg ? Color.greenPrimary.opacity(0.5) : Color.clear)
                .cornerRadius(8, corners: .allCorners)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
        }
    }
}
