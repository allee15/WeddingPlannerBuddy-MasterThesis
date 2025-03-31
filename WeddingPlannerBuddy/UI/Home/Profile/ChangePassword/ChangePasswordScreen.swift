//
//  ChangePasswordScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 08.12.2024.
//

import SwiftUI

struct ChangePasswordScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = ChangePasswordViewModel()
    @FocusState var focusedField: ChangePasswordField?
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Change password") {
                if !viewModel.newPassword.isEmpty || !viewModel.confirmNewPassword.isEmpty {
                    let modal = ModalChooseOptionView(title: "Are you sure?",
                                                      description: "Are you sure you want to go back? All your changes will be lost.",
                                                      topButtonText: "Go back",
                                                      bottomButtonText: "Stay") {
                        navigation.dismissModal(animated: true, completion: nil)
                        navigation.pop(animated: true)
                    } onBottomButtonTapped: {
                        navigation.dismissModal(animated: true, completion: nil)
                    }
                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                } else {
                    navigation.pop(animated: true)
                }
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Set a new password. Make sure it has at least 6 characters for better security.")
                        .font(.quicksandRegular(size: 14))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    
                    FloatingField(text: $viewModel.actualPassword,
                                  placeHolder: "Actual password",
                                  secureField: true)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .currentPassword)
                    .onSubmit {
                        focusedField = .newPassword
                    }
                    .padding(.bottom, 12)
                    
                    FloatingField(text: $viewModel.newPassword,
                                  placeHolder: "New password",
                                  secureField: true,
                                  errorMessage: viewModel.errorMessagePassword)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .newPassword)
                    .onSubmit {
                        focusedField = .confirmNewPassword
                    }
                    .padding(.bottom, 12)
                    
                    FloatingField(text: $viewModel.confirmNewPassword,
                                  placeHolder: "Confirm new password",
                                  secureField: true,
                                  errorMessage: viewModel.errorMessageConfirmNewPassword)
                    .focused($focusedField, equals: .confirmNewPassword)
                    .padding(.bottom, 12)
                    
                }.padding(.horizontal, 16)
                    .padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Save new password") {
                    viewModel.changePassword()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
            .onTapGesture {
                hideKeyboard()
            }
            .onChange(of: viewModel.newPassword) { _, newValue in
                viewModel.errorMessagePassword = nil
            }
            .onChange(of: viewModel.confirmNewPassword) { _, newValue in
                viewModel.errorMessageConfirmNewPassword = nil
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    navigation.pop(animated: true)
                    let toast = Toast(text: "Edit successful!")
                    ToastManager.instance.show(toast)
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
    ChangePasswordScreen()
}
