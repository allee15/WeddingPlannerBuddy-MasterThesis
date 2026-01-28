//
//  EditDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI
import Kingfisher

struct EditDressScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditDressViewModel
    @State private var addPhoto: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit dress") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    FloatingField(text: $viewModel.newDescription,
                                  placeHolder: "Description")
                    
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
                    FloatingField(text: $viewModel.newLink,
                                  placeHolder: "Link")
                    
                    SecondaryButtonView(text: "Add image") {
                        self.addPhoto = true
                    }
                    .sheet(isPresented: $addPhoto) {
                        ImagePickerView(sourceType: self.$imageSource) { image in
                            viewModel.addImage(image: image)
                        }
                        .ignoresSafeArea()
                    }
                    
                    if !viewModel.weddingDress.photo.isEmpty {
                        ZStack(alignment: .center) {
                            Color.nudePrimary.opacity(0.4)
                                .cornerRadius(8, corners: .allCorners)
                            
                            KFImage(URL(string: "http://localhost:8000/\(viewModel.weddingDress.photo)"))
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height / 3)
                                .padding(.all, 12)
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
                viewModel.editDress()
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
