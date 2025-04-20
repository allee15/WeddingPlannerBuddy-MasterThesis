//
//  EditDateScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 04.04.2025.
//

import SwiftUI

struct EditDateScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditDateViewModel
    @State private var showDatePicker: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit date") {
                navigation.pop(animated: true)
            }
            
            Text("Need to reschedule your big day? No worries! Use this screen to select a new wedding date and make sure everything is just right for your special moment.")
                .font(.quicksandRegular(size: 14))
                .foregroundStyle(Color.mainBlack)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                .padding(.top, 4)
            
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
                    .padding(.top, 16)
                
                DividerView(color: Color.nudePrimary)
                
                if showDatePicker {
                    DatePicker("", selection: $viewModel.newDate,
                               in: (Date())..., displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .accentColor(Color.greenSecondary)
                    .background(Color.nudePrimary.opacity(0.35))
                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                }
            }.padding(.horizontal, 16)
            Spacer()
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom, content: {
                MainButtonView(text: "Edit date") {
                    viewModel.editDate()
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
