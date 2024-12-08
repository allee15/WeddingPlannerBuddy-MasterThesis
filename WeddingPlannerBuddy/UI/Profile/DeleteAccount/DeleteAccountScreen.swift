//
//  DeleteAccountScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 08.12.2024.
//

import SwiftUI

struct DeleteAccountScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = DeleteAccountViewModel()
    @FocusState var focusedField: DeleteAccountField?
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Delete account") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("In order to procces your request, please enter your password.")
                        .foregroundStyle(Color.mainBlack)
                        .font(.poppinsRegular(size: 14))
                    
                    FloatingField(text: $viewModel.actualPassword,
                                  placeHolder: "Your password",
                                  secureField: true,
                                  errorMessage: viewModel.errorMessagePassword)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .currentPassword)
                    
                }.padding(.horizontal, 16)
                    .padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                VStack(spacing: 8) {
                    MainButtonView(text: "Delete account") {
                        viewModel.deleteAccount()
                    }
                    
                    ClearButton(text: "Close") {
                        navigation.pop(animated: true)
                    }
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
            .onTapGesture {
                hideKeyboard()
            }
            .onChange(of: viewModel.actualPassword) { _, newValue in
                viewModel.errorMessagePassword = nil
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .error:
                    navigation.pop(animated: true)
                    let toast = Toast(text: "An error has occured. Please try again!", textColor: Color.lightRed)
                    ToastManager.instance.show(toast)
                }
            }
    }
}

#Preview {
    DeleteAccountScreen()
}
