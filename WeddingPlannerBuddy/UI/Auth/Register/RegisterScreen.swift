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
        VStack(spacing: 36) {
            NavBarView()
            
            Text("Wedding Planner Buddy")
                .foregroundStyle(Color.mainBlack)
                .font(.poppinsBold(size: 28))
                .padding(.horizontal, 16)
            
            Text("Let's create your account. Fill in the fields below to let the big day's planning begin.")
                .foregroundStyle(Color.mainBlack)
                .font(.poppinsRegular(size: 14))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
            
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
                    HStack(alignment: .top) {
                        Toggle(isOn: $viewModel.termsAccepted) {
                            Group {
                                Text("I read and agree to ")
                                    .foregroundColor(.black)
                                + Text("The Terms and Conditions")
                                    .foregroundColor(Color.mainPink)
                            }.font(.poppinsRegular(size: 14))
                                .onTapGesture {
                                    let webview = WebViewScreen(
                                        title: "Terms and Conditions",
                                        url: URL(string: "https://www.termsfeed.com/live/45bb0a23-92d0-4964-9cd4-d0b3c6a32bc1")!
                                    ).asDestination()
                                    navigation.push(webview, animated: true)
                                }
                        }.toggleStyle(CheckboxToggleStyle())
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
                
                MainButtonView(text: "Create account") {
                    viewModel.allFieldsAreValid()
                }.padding(.horizontal, 16)
            }
            
            Spacer()
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
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
