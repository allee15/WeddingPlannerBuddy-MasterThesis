//
//  ProfileScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = ProfileViewModel()
    private let mainNavigation = EnvironmentObjects.navigation
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Profile", hasBackButton: true) {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    if let user = viewModel.user {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.quicksandSemiBold(size: 20))
                                .foregroundStyle(Color.mainBlack)
                                .padding(.horizontal, 16)
                            
                            WidgetView(title: "Change password", icon: .icChangePassword) {
                                navigation.push(ChangePasswordScreen().asDestination(),
                                                animated: true)
                            }
                            
                            WidgetView(title: "Logout", icon: .icLogout) {
                                navigation.push(LogoutScreen().asDestination(), animated: true)
                            }
                            
                            WidgetView(title: "Delete account", icon: .icDeleteAccount) {
                                navigation.push(DeleteAccountScreen().asDestination(), animated: true)
                            }
                        }
                        
                        WidgetView(title: "Weddings to attend", icon: .icWeddingsProfile) {
                            let vm = OtherWeddingsViewModel(otherWeddingsList: user.otherWeddings)
                            navigation.push(OtherWeddingsScreen(viewModel: vm).asDestination(),
                                            animated: true)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Legal")
                            .font(.quicksandSemiBold(size: 20))
                            .foregroundStyle(Color.mainBlack)
                            .padding(.horizontal, 16)
                        
                        WidgetView(title: "Terms and Conditions", icon: .icTerms) {
                            let webview = WebViewScreen(
                                title: "Terms and Conditions",
                                url: URL(string: "https://www.termsfeed.com/live/45bb0a23-92d0-4964-9cd4-d0b3c6a32bc1")!
                            ).asDestination()
                            navigation.push(webview, animated: true)
                        }
                        
                        WidgetView(title: "Contact us", icon: .icContactus) {
                            let email = "alexia.elena.aldea@gmail.com"
                            let urlString = "mailto:\(email)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            
                            if let url = URL(string: urlString ?? "") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Version")
                            .font(.quicksandSemiBold(size: 20))
                            .foregroundStyle(Color.mainBlack)
                            .padding(.horizontal, 16)
                        
                        WidgetView(title: "App version \(viewModel.appVersion)", icon: .icAppVersion, showToggle: false, hasBg: false) {}
                    }
                }.padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .safeAreaInset(edge: .bottom) {
                if viewModel.user == nil {
                    MainButtonView(text: "Login") {
                        mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                    }.padding([.horizontal, .bottom], 16)
                }
            }
    }
}
