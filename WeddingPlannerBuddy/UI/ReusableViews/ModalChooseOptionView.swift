//
//  ModalChooseOptionView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct ModalChooseOptionView: View {
    let title: String
    let description: String
    let topButtonText: String
    var middleButtonText: String?
    var bottomButtonText: String?
    let onTopButtonTapped: () -> ()
    var middleButtonTapped: (() -> ())?
    var onBottomButtonTapped: (() -> ())?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 0) {
                Image(.icInfo)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 8)
                
                Text(title)
                    .font(.quicksandSemiBold(size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                
                Text(description)
                    .font(.quicksandRegular(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 28)
                
                VStack(spacing: 12) {
                    MainButtonView(text: topButtonText,
                                   bgColor: Color.greenPrimary.opacity(0.6),
                                   textColor: Color.mainBlack) {
                        onTopButtonTapped()
                    }
                    
                    if let middleButtonTapped = middleButtonTapped,
                       let middleButtonText = middleButtonText {
                        SecondaryButtonView(text: middleButtonText) {
                            middleButtonTapped()
                        }
                    }
                    
                    if let onBottomButtonTapped = onBottomButtonTapped,
                       let bottomButtonText = bottomButtonText {
                        ClearButton(text: bottomButtonText) {
                            onBottomButtonTapped()
                        }
                    }
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(Color.mainWhite.cornerRadius(8))
                .padding(.horizontal, 24)
        }.ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

