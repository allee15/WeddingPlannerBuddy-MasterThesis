//
//  EditFoodMenuScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 05.04.2025.
//

import SwiftUI

struct EditFoodMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditFoodMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit food menu") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
                    FloatingField(text: $viewModel.newAntreu,
                                  placeHolder: "Entry course")
                    
                    FloatingField(text: $viewModel.newFirstCourse,
                                  placeHolder: "First course")
                    
                    FloatingField(text: $viewModel.newMainCourse,
                                  placeHolder: "Main course")
                    
                    FloatingField(text: $viewModel.newSecondMainCourse,
                                  placeHolder: "Second course")
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
                viewModel.addNewItems()
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

