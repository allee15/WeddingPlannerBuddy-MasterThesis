//
//  AddParticipantView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 11.12.2024.
//

import SwiftUI

struct AddParticipantScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @FocusState var focusedField: ProfileField?
    @StateObject var viewModel: AddParticipantViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Add guest") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    FloatingField(text: $viewModel.name,
                                  placeHolder: "Name",
                                  leftIcon: .icFieldName)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .email
                    }
                    .padding(.horizontal, 16)
                    
                    FloatingField(text: $viewModel.email,
                                  placeHolder: "Email address",
                                  leftIcon: .icFieldEmail)
                    .submitLabel(.return)
                    .focused($focusedField, equals: .email)
                    .padding(.horizontal, 16)
                    
                    Image(.imgAddGuest)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }.padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Add guest",
                              isDisabled: !viewModel.hasChanges()) {
                    viewModel.addParticipant()
                }.padding(.horizontal, 16)
                    .padding(.bottom, 8)
            })
            .onTapGesture {
                hideKeyboard()
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    navigation.pop(animated: true)
                    let toast = Toast(text: "Partipicant added successful!")
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
