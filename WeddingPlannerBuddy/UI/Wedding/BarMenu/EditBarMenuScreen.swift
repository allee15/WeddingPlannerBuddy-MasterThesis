//
//  EditBarMenuScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 05.04.2025.
//

import SwiftUI

struct EditBarMenuScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditBarMenuViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit bar menu") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
                    FloatingField(text: $viewModel.newAlcool,
                                  placeHolder: "Alcohol drink")
                    
                    FloatingField(text: $viewModel.newNonAlcool,
                                  placeHolder: "Non-alcohol drink")
                    
                    FloatingField(text: $viewModel.newCoffee,
                                  placeHolder: "Coffee")
                    
                    FloatingField(text: $viewModel.newJuice,
                                  placeHolder: "Juice")
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

