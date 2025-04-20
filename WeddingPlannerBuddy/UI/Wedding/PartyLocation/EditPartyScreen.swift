//
//  EditPartyScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI

struct EditPartyScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditPartyViewModel
    @State private var addPhoto: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State var showDatePicker: Bool = false
    @State var showHourPicker: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit after-party") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    FloatingField(text: $viewModel.newDescription,
                                  placeHolder: "Description")
                    
                    FloatingField(text: $viewModel.newAddress,
                                  placeHolder: "Address")
                    
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            DateView(
                                placeHolder: "Select date",
                                date: $viewModel.newDate,
                                singleDateSelected: viewModel.newDate) {
                                    if !showDatePicker {
                                        showDatePicker = true
                                    } else {
                                        showDatePicker = false
                                    }
                                }.background(Color.nudePrimary.opacity(0.5))
                                .cornerRadius(8, corners: [.topLeft, .topRight])

                            DividerView(color: Color.nudePrimary)

                            if showDatePicker {
                                DatePicker("", selection: $viewModel.newDate,
                                           in: (Date())..., displayedComponents: .date)
                                .datePickerStyle(WheelDatePickerStyle())
                                .accentColor(Color.greenSecondary)
                                .background(Color.nudePrimary.opacity(0.35))
                                .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                            }
                        }
                        
                        VStack(spacing: 0) {
                            DateView(
                                placeHolder: "Select hour",
                                date: $viewModel.newHour,
                                singleDateSelected: viewModel.newHour,
                                showHour: true) {
                                    if !showHourPicker {
                                        showHourPicker = true
                                    } else {
                                        showHourPicker = false
                                    }
                                }.background(Color.nudePrimary.opacity(0.5))
                            
                            DividerView(color: Color.nudePrimary)
                            
                            if showHourPicker {
                                DatePicker("", selection: $viewModel.newHour,
                                           in: (Date())..., displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .accentColor(Color.greenSecondary)
                                .background(Color.nudePrimary.opacity(0.35))
                                .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
        }
        .background(Color.mainWhite)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
        .safeAreaInset(edge: .bottom, content: {
            MainButtonView(text: "Edit details") {
                viewModel.editParty()
            }.padding(.horizontal, 16)
                .padding(.bottom, 8)
        })
        .onReceive(viewModel.eventSubject) { event in
            switch event {
            case .completed:
                navigation.popToRoot(animated: true)
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
