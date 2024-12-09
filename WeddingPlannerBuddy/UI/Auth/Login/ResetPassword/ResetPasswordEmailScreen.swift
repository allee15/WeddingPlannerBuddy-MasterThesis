//
//  ResetPasswordEmailScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 09.12.2024.
//

import SwiftUI

struct ResetPasswordEmailScreen: View {
    @EnvironmentObject private var navigation: Navigation
    
    @StateObject var viewModel: ResetPasswordEmailViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            LeftNavBarView(title: "Reset password") {
                navigation.pop(animated: true)
            }
            
            VStack(spacing: 16) {
                Text("We've sent you an email")
                    .font(.poppinsBold(size: 28))
                    .foregroundColor(.mainBlack)
                
                Text("Follow the instructions in the email to reset your password. If you can't find it, search also in the spam folder.")
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 16)
            
            Spacer()
            
            VStack(spacing: 8) {
                Group {
                    Text("Didn't receive an email? Retry in ")
                        .foregroundColor(.mainBlack)
                        .font(.poppinsRegular(size: 14)) +
                    Text("\(viewModel.formattedTime())")
                        .foregroundColor(Color.mainPink)
                        .font(.poppinsSemiBold(size: 14))
                }
                
                MainButtonView(text: "Resend email",
                              isDisabled: viewModel.timeRemaining != 0) {
                    viewModel.resetPassword()
                }
                
                ClearButton(text: "Back to start page") {
                    navigation.popTo(tag: "login", animated: true)
                }
            }.padding(.horizontal, 16)
                .padding(.bottom, 32)
            
        }.background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                viewModel.startTimer()
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                viewModel.updateTimer()
            }
        }
    }
}
