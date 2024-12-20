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
    @StateObject private var viewModel = AddParticipantViewModel()
    @Binding var showBottomSheet: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    VStack(spacing: 40) {
                        BottomSheetLineView()
                        
                        HStack {
                            Text("Add participant")
                                .font(.poppinsBold(size: 28))
                                .foregroundStyle(Color.mainBlack)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                        
                    }.padding(.top, 12)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        FloatingField(text: $viewModel.name,
                                      placeHolder: "Participant's name")
                        .submitLabel(.next)
                        .focused($focusedField, equals: .name)
                        .onSubmit {
                            focusedField = .email
                        }
                        
                        FloatingField(text: $viewModel.email,
                                      placeHolder: "Participant's email")
                        .submitLabel(.return)
                        .focused($focusedField, equals: .email)
                        
                        Spacer(minLength: 80)
                    }.padding(.horizontal, 20)
                } 
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Save",
                              isDisabled: !viewModel.hasChanges()) {
                    viewModel.addParticipant()
                }.padding([.horizontal, .bottom], 16)
            })
            .onTapGesture {
                hideKeyboard()
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    self.showBottomSheet = false
                    let toast = Toast(text: "Partipicant added successful!", textColor: Color.lightGreen)
                    ToastManager.instance.show(toast)
                    
                case .error:
                    self.showBottomSheet = false
                    let toast = Toast(text: "An error has occured. Please try again!", textColor: Color.lightRed)
                    ToastManager.instance.show(toast)
                }
            }
    }
}
