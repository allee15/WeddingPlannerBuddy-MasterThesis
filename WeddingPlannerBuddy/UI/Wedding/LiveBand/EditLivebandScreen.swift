//
//  EditLivebandScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI

struct EditLivebandScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditLivebandViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit live band") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    FloatingField(text: $viewModel.newName,
                                  placeHolder: "Name")
                    
                    FloatingField(text: $viewModel.newDescription,
                                  placeHolder: "Details")
                    
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    //TODO: fixme
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
                viewModel.editBand()
            }.padding(.horizontal, 16)
                .padding(.bottom, 8)
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
