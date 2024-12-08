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
        VStack(spacing: 36) {
            NavBarView(isCloseButton: true)
            
            Text("Wedding Planner Buddy")
                .foregroundStyle(Color.mainBlack)
                .font(.poppinsBold(size: 28))
                .padding(.horizontal, 16)
            
            DetailsView()
            
            VStack(spacing: 20) {
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
                
                MainButtonView(text: "Login") {
                    viewModel.allFieldsAreValid()
                }.padding(.horizontal, 16)
                
                ClearButton(text: "Forgot password?") {
                    navigation.push(ResetPasswordScreen().asDestination(), animated: true)
                }
            }
            
            Spacer()
        }.background(Color.mainWhite)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
                .safeAreaInset(edge: .bottom, content: {
                    ClearButton(text: "Create account") {
                        navigation.push(RegisterScreen().asDestination(), animated: true)
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
                    Circle()
                        .stroke(Color.mainPink, lineWidth: 4)
                        .frame(height: 16)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text("Keep all your plans and budgets in one place.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.poppinsRegular(size: 14))
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 8) {
                    Circle()
                        .stroke(Color.mainPink, lineWidth: 4)
                        .frame(height: 16)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text("Organize your guests at tables.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.poppinsRegular(size: 14))
                        .multilineTextAlignment(.leading)
                }
                
                HStack(spacing: 8) {
                    Circle()
                        .stroke(Color.mainPink, lineWidth: 4)
                        .frame(height: 16)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text("Share your memories from the big day with friends.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.poppinsRegular(size: 14))
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
