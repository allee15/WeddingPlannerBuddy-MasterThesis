//
//  LoginScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = LoginViewModel()
    @FocusState var focusedField: LoginField?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavBarView(isCloseButton: true)
            
            Text("Wedding Planner Buddy")
                .foregroundStyle(Color.mainBlack)
                .font(.quicksandSemiBold(size: 28))
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            
            DetailsView()
            
            VStack(spacing: 16) {
                FloatingField(text: $viewModel.email,
                              placeHolder: "Email address",
                              keyboardType: .emailAddress,
                              leftIcon: .icFieldEmail,
                              errorMessage: viewModel.emailError)
                .padding(.horizontal, 16)
                .submitLabel(.next)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
                
                FloatingField(text: $viewModel.password,
                              placeHolder: "Password",
                              secureField: true,
                              leftIcon: .icFieldPassword,
                              errorMessage: viewModel.passwordError)
                .padding(.horizontal, 16)
                .submitLabel(.done)
                .focused($focusedField, equals: .password)
                
                HStack {
                    Spacer()
                    Button {
                        navigation.push(ResetPasswordScreen().asDestination(), animated: true)
                    } label: {
                        Text("Forgot password?")
                            .underline()
                            .font(.quicksandMedium(size: 14))
                            .foregroundStyle(Color.mainBlack)
                    }
                }.padding(.horizontal, 16)
            }.padding(.top, 24)
            
            Spacer()
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
            .safeAreaInset(edge: .bottom, content: {
                VStack(spacing: 12) {
                    MainButtonView(text: "Login") {
                        viewModel.allFieldsAreValid()
                    }
                    
                    SecondaryButtonView(text: "Create account") {
                        navigation.push(RegisterScreen().asDestination(), animated: true)
                    }
                }.padding(.horizontal, 16)
                    .padding(.bottom, 8)
            })
            .onChange(of: viewModel.email) { _, _ in
                viewModel.emailError = nil
            }
            .onChange(of: viewModel.password) { _, _ in
                viewModel.passwordError = nil
            }
            .onReceive(viewModel.loginCompletion) { event in
                switch event {
                case .login:
                    break
                    
                case .failure(let error):
                    let modal = ModalChooseOptionView(title: "Error",
                                                      description: "An error has occured. Please try again.",
                                                      topButtonText: "Try again") {
                        navigation.dismissModal(animated: true, completion: nil)
                    }
                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                }
            }
    }
}

fileprivate struct DetailsView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Image(.icLoginCircle)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.mainBlack)
                    
                    Text("Keep all your plans and budgets in one place.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandRegular(size: 14))
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 8) {
                    Image(.icLoginCircle)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.mainBlack)
                    
                    Text("Organize your guests at tables.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandRegular(size: 14))
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 8) {
                    Image(.icLoginCircle)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.mainBlack)
                    
                    Text("Share your memories from the big day with friends.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.quicksandRegular(size: 14))
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }.padding(.horizontal, 16)
    }
}

#Preview {
    LoginScreen()
}
