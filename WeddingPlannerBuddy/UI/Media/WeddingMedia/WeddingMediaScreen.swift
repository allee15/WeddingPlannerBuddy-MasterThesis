//
//  WeddingMediaScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import SwiftUI
import Kingfisher
import StoreKit

struct WeddingMediaScreen: View {
    @EnvironmentObject private var navigation: Navigation
    private let mainNavigation = EnvironmentObjects.navigation
    @StateObject var viewModel: WeddingMediaViewModel
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @State private var addPhoto: Bool = false
    
    @State private var showNavBar: Bool = true
    @State private var showBottomBar: Bool = true
    @State private var scrollOffset: CGFloat = 0.0
    @State private var previousScrollOffset: CGFloat = 0.0
    @State private var totalViewHeight: CGFloat = 0.0
    let viewportHeight = UIScreen.main.bounds.height
    
    let columns = [
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width - 38) / 3,
                           maximum: UIScreen.main.bounds.width / 3)),
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width - 38) / 3,
                           maximum: UIScreen.main.bounds.width / 3)),
        GridItem(.flexible(minimum: (UIScreen.main.bounds.width - 38) / 3,
                           maximum: UIScreen.main.bounds.width / 3))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            if showNavBar {
                LeftNavBarView(title: viewModel.wedding.name) {
                    navigation.pop(animated: true)
                }
            }
            
            ScrollView(showsIndicators: false) {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            scrollOffset = proxy.frame(in: .global).minY
                            previousScrollOffset = scrollOffset
                        }
                        .onChange(of: proxy.frame(in: .global).minY) { _, value in
                            let scrollDifference = value - previousScrollOffset
                            scrollOffset = value
                            
                            if (abs(value) + viewportHeight) >= totalViewHeight {
                                // is at the bottom
                                if !showNavBar && !showBottomBar {
                                    showNavBar = true
                                    showBottomBar = true
                                }
                            } else if value > 0 {
                                // scroll to top
                                withAnimation {
                                    showNavBar = true
                                    showBottomBar = true
                                }
                            } else if abs(scrollDifference) > 10 {
                                if scrollOffset < previousScrollOffset {
                                    // scroll to bottom
                                    if showNavBar && showBottomBar {
                                        withAnimation {
                                            showNavBar = false
                                            showBottomBar = false
                                        }
                                    }
                                } else {
                                    // scroll to top
                                    withAnimation {
                                        showNavBar = true
                                        showBottomBar = true
                                    }
                                }
                            }
                            previousScrollOffset = scrollOffset
                        }
                }.frame(height: 0)
                
                VStack(spacing: 0) {
                    if !viewModel.wedding.images.isEmpty {
                        LazyVGrid(columns: columns, spacing: 4) {
                            ForEach(viewModel.wedding.images, id: \.self) { image in
                                Button {
                                    mainNavigation?.push(ZoomImageScreen(imageToZoom: "http://localhost:8000/\(image)").asDestination(),
                                                         animated: true)
                                } label: {
                                    KFImage(URL(string: "http://localhost:8000/\(image)"))
                                        .resizable()
                                        .placeholder {
                                            Image(.imgPlaceholder)
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: (UIScreen.main.bounds.width - 38) / 3)
                                        }
                                        .centerCropped()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: (UIScreen.main.bounds.width - 38) / 3)
                                        .cornerRadius(4)
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    } else {
                        Spacer()
                        EmptyStateView(title: "📸 No memories here... yet!",
                                       subtitle: "Select your wedding and start adding beautiful moments to your gallery. 💍✨")
                        Spacer()
                    }
                }.padding(.top, 24)
                    .padding(.horizontal, 16)
            }.safeAreaInset(edge: .bottom) {
                if showBottomBar {
                    MainButtonView(text: "Add image") {
                        self.addPhoto = true
                    }.padding(.horizontal, 16)
                        .padding(.bottom, 24)
                        .sheet(isPresented: $addPhoto) {
                            ImagePickerView(sourceType: self.$imageSource) { image in
                                viewModel.addImage(image: image)
                            }
                            .ignoresSafeArea()
                        }
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .added:
                    self.addPhoto = false
                    let toast = Toast(text: "Image added successfully!")
                    ToastManager.instance.show(toast)
                    
                case .showRateModal:
                    if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene)
                    }
                    
                case .failed:
                    let toast = Toast(text: "An error has occured. Please try again!",
                                                  textColor: Color.darkRed,
                                                  bg: Color.lightRed,
                                                  icon: .icToastRed)
                    ToastManager.instance.show(toast)
                }
            }
    }
}
