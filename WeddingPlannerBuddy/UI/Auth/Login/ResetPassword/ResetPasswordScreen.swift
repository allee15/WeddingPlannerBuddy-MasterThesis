//
//  ResetPasswordScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 08.12.2024.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = ResetPasswordViewModel()
    @FocusState var focusedField: ResetPasswordField?
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Reset password") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("In order to procces your request, please enter your email.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandSemiBold(size: 16))
                    
                    FloatingField(text: $viewModel.email,
                                  placeHolder: "Email address",
                                  keyboardType: .emailAddress,
                                  leftIcon: .icFieldEmail,
                                  errorMessage: viewModel.errorMessageEmail)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .currentPassword)
                    
                }.padding(.horizontal, 16)
                    .padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Reset password") {
                    viewModel.resetPassword()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
            .onTapGesture {
                hideKeyboard()
            }
            .onChange(of: viewModel.email) { _, newValue in
                viewModel.errorMessageEmail = nil
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    let vm = ResetPasswordEmailViewModel(email: viewModel.email)
                    navigation.push(ResetPasswordEmailScreen(viewModel: vm).asDestination(), animated: true)
                case .error:
                    navigation.pop(animated: true)
                    let toast = Toast(text: "An error has occured. Please try again!",
                                      textColor: Color.darkRed,
                                      bg: Color.lightRed,
                                      icon: .icToastRed)
                    ToastManager.instance.show(toast)
                }
            }
    }
}

#Preview {
    ResetPasswordScreen()
}
