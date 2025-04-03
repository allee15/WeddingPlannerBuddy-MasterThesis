//
//  EditCakeScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import SwiftUI
import Kingfisher

struct EditCakeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: EditCakeViewModel
    @State private var addPhoto: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Edit cake") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    FloatingField(text: $viewModel.newName,
                                  placeHolder: "Name")
                    
                    FloatingField(text: $viewModel.newDescription,
                                  placeHolder: "Description")
                    
                    FloatingField(text: $viewModel.newPrice,
                                  placeHolder: "Price")
                    
                    SecondaryButtonView(text: "Add image") {
                        self.addPhoto = true
                    }
                    .sheet(isPresented: $addPhoto) {
                        ImagePickerView(sourceType: self.$imageSource) { image in
                            viewModel.addImage(image: image)
                        }
                        .ignoresSafeArea()
                    }
                    
                    ZStack(alignment: .center) {
                        Color.nudePrimary.opacity(0.4)
                        KFImage(URL(string: viewModel.newImageURL?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? "")) //TODO: checkme
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 24)
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
                viewModel.editCake()
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
