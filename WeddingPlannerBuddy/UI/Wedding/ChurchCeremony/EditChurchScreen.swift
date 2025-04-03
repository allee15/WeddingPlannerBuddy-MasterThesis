//
//  EditChurchScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI
//TODO: fix me
struct EditChurchScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditChurchViewModel
    @State private var addPhoto: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit church marriage") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    FloatingField(text: $viewModel.newPreotName,
                                  placeHolder: "Priest name")
                    
                    FloatingField(text: $viewModel.newAddress,
                                  placeHolder: "Address")
                    
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
//                    VStack(spacing: 0) {
//                        DateView(
//                            placeHolder: "Select date",
//                            date: $viewModel.newDate,
//                            singleDateSelected: viewModel.newDate) {
//                                showDatePicker = true
//                            }.background(Color.nudePrimary.opacity(0.5))
//                            .cornerRadius(8, corners: [.topLeft, .topRight])
//                            .padding(.top, 16)
//                        
//                        DividerView(color: Color.nudePrimary)
//                        
//                        DatePicker("", selection: $viewModel.newDate,
//                                   in: (Date())..., displayedComponents: .date)
//                            .datePickerStyle(WheelDatePickerStyle())
//                            .accentColor(Color.greenSecondary)
//                            .background(Color.nudePrimary.opacity(0.35))
//                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
//                    }
                    
//                    VStack(spacing: 0) {
//                        DateView(
//                            placeHolder: "Select hour",
//                            date: $viewModel.newHour,
//                            singleDateSelected: viewModel.newHour) {
//                                showDatePicker = true
//                            }.background(Color.nudePrimary.opacity(0.5))
//                            .cornerRadius(8, corners: [.topLeft, .topRight])
//                            .padding(.top, 16)
//                        
//                        DividerView(color: Color.nudePrimary)
//                        
//                        DatePicker("", selection: $viewModel.newHour,
//                                   in: (Date())..., displayedComponents: .date)
//                            .datePickerStyle(WheelDatePickerStyle())
//                            .accentColor(Color.greenSecondary)
//                            .background(Color.nudePrimary.opacity(0.35))
//                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
//                    }
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
                viewModel.editChurch()
            }
        })
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
