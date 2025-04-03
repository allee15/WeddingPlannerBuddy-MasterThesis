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
            
            VStack(alignment: .leading, spacing: 8) {
                Text("We've sent you an email")
                    .font(.quicksandSemiBold(size: 20))
                    .foregroundColor(.mainBlack)
                
                Text("Follow the instructions in the email to reset your password. If you can't find it, search also in the spam folder.")
                    .font(.quicksandRegular(size: 14))
                    .foregroundColor(Color.mainBlack)
                    .multilineTextAlignment(.leading)
            }.padding(.horizontal, 16)
            
            HStack {
                Button {
                    viewModel.resetPassword()
                } label: {
                    Group {
                        Text("Didn't receive an email? Retry in ")
                            .underline()
                            .foregroundColor(.mainBlack)
                            .font(.quicksandMedium(size: 12)) +
                        Text("\(viewModel.formattedTime())")
                            .underline()
                            .foregroundColor(Color.greenSecondary)
                            .font(.quicksandMedium(size: 12))
                    }
                }
                Spacer()
            }.padding(.horizontal, 16)
            
            Spacer()
            
        }.background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Go to login",
                              isDisabled: viewModel.timeRemaining != 0) {
                    navigation.popTo(tag: "login", animated: true)
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
            .onAppear {
                viewModel.startTimer()
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                viewModel.updateTimer()
            }
        }
    }
}
