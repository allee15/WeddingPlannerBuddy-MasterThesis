//
//  RegisterScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct RegisterScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = RegisterViewModel()
    @FocusState var focusedField: LoginField?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            LeftNavBarView(title: "Register") {
                navigation.pop(animated: true)
            }
            
            Text("Wedding Planner Buddy")
                .foregroundStyle(Color.mainBlack)
                .font(.poppinsBold(size: 28))
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            
            Text("Let's create your account. Fill in the fields below to let the big day's planning begin.")
                .foregroundStyle(Color.mainBlack)
                .font(.poppinsRegular(size: 14))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            
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
                
                VStack(spacing: 4) {
                    HStack(alignment: .top, spacing: 8) {
                        Button {
                            viewModel.termsAccepted.toggle()
                        } label: {
                            Image(viewModel.termsAccepted ? .icAcceptedTerms : .icUnacceptedTerms)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color.mainBlack)
                                .frame(width: 20, height: 20)
                        }
                        
                        Group {
                            Text("I have read and agreed to ")
                                .foregroundColor(.mainBlack)
                            + Text("The Terms and Conditions")
                                .underline()
                                .foregroundColor(Color.greenSecondary)
                        }.font(.quicksandMedium(size: 14))
                            .onTapGesture {
                                let webview = WebViewScreen(
                                    title: "Terms and Conditions",
                                    url: URL(string: "https://www.termsfeed.com/live/45bb0a23-92d0-4964-9cd4-d0b3c6a32bc1")!
                                ).asDestination()
                                navigation.push(webview, animated: true)
                            }
                        
                        Spacer()
                    }
                    
                    if let error = viewModel.termsError {
                        HStack {
                            Text(error)
                                .font(.poppinsRegular(size: 12))
                                .foregroundColor(Color.lightRed)
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }.padding(.horizontal, 16)
            }
            
            Spacer()
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Create account") {
                    viewModel.allFieldsAreValid()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 8)
            })
            .onChange(of: viewModel.email) { _, _ in
                viewModel.emailError = nil
            }
            .onChange(of: viewModel.password) { _, _ in
                viewModel.passwordError = nil
            }
            .onChange(of: viewModel.termsAccepted, { _, _ in
                viewModel.termsError = nil
            })
            .onReceive(viewModel.registerCompletion) { event in
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

fileprivate struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(configuration.isOn ? "Type=On" : "Type=Off")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(Color.mainPink)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}

#Preview {
    RegisterScreen()
}
