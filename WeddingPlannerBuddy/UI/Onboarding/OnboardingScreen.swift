//
//  OnboardingScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct OnboardingScreen: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $viewModel.pageIndex) {
                ForEach(0..<3) { index in
                    OnboardingPageView(page: viewModel.onboardingPages[index])
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                Button {
                    viewModel.goToLogin()
                } label: {
                    Text("SKIP")
                        .font(.poppinsSemiBold(size: 14))
                        .foregroundColor(Color.mainBlack)
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.all, 16)
                }
                
                Spacer()
                
                NavSliderView(currentStep: viewModel.pageIndex) {
                    viewModel.nextPage()
                }
                
                Spacer()
                
                Button {
                    viewModel.nextPage()
                } label: {
                    Text("NEXT")
                        .font(.poppinsSemiBold(size: 14))
                        .foregroundColor(Color.mainWhite)
                        .lineLimit(1)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.all, 16)
                        .background(Color.mainBlack)
                        .cornerRadius(4, corners: .allCorners)
                }
            }.padding(.horizontal, 20)
            
            Spacer()
        }.padding(.bottom, 32)
            .background(Color.mainPink.opacity(0.3))
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .completed:
                    navigation.push(LoginScreen().asDestination(), animated: true)
                case .goToTabBar:
                    navigation.replaceNavigationStack([TabBarScreen().asDestination()], animated: true)
                    
                }
            }
    }
}

fileprivate struct OnboardingPageView: View {
    let page: OnboardingData
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    Spacer()
                    Image(page.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height / 2 )
                        .cornerRadius(8, corners: .allCorners)
                    Spacer()
                }
                
                Text(page.title)
                    .font(.poppinsBold(size: 28))
                    .foregroundStyle(Color.mainPink)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(page.description)
                    .font(.poppinsRegular(size: 14))
                    .foregroundStyle(Color.mainPink)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }.padding(.horizontal, 20)
        }
    }
}

fileprivate struct NavSliderView: View {
    let currentStep: Int
    let buttonAction: () -> ()
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { step in
                Button {
                    buttonAction()
                } label: {
                    Circle()
                        .fill(step == currentStep ? Color.mainPink : Color.gray)
                        .frame(height: 12)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        
    }
}
