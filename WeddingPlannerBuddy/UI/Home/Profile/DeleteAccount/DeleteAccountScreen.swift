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
                VStack(alignment: .leading, spacing: 0) {
                    Text("Thinking of leaving? Are you sure you want to delete your account?")
                        .font(.quicksandMedium(size: 20))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    
                    Text("We’re sad to see you go! Keep in mind that this will permanently remove all your data, and you won’t be able to recover it. In order to procces your request, please enter your password.")
                        .font(.quicksandRegular(size: 14))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                    
                    FloatingField(text: $viewModel.actualPassword,
                                  placeHolder: "Your password",
                                  secureField: true,
                                  errorMessage: viewModel.errorMessagePassword)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .currentPassword)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                    
                    Image(.imgDeleteAccount)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }.padding(.top, 20)
            }
        }
        .background(Color.mainWhite)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Delete my account") {
                    viewModel.deleteAccount()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 12)
            })
            .onReceive(viewModel.eventSubject) { event in
                switch event {
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
    DeleteAccountScreen()
}
