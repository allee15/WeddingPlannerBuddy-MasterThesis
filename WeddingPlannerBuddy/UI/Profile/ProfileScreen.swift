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
            LeftNavBarView(title: "Profile", hasBackButton: false) { }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    if let user = viewModel.user {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account")
                                .font(.poppinsSemiBold(size: 16))
                                .foregroundStyle(Color.mainBlack)
                                .padding(.horizontal, 16)
                            
                            WidgetView(title: "Change password", icon: .icChangePassword) {
                                navigation.push(ChangePasswordScreen().asDestination(),
                                                animated: true)
                            }
                            
                            WidgetView(title: "Logout", icon: .icLogout) {
                                let modal = ModalChooseOptionView(title: "Are you sure you want to logout?",
                                                                  description: "You will not have access to your chats if you are logged out.",
                                                                  topButtonText: "Logout",
                                                                  bottomButtonText: "Cancel") {
                                    viewModel.logOut()
                                    navigation.dismissModal(animated: true, completion: nil)
                                } onBottomButtonTapped: {
                                    navigation.dismissModal(animated: true, completion: nil)
                                }
                                
                                navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                            }
                            
                            WidgetView(title: "Delete account", icon: .icDeleteAccount) {
                                navigation.push(DeleteAccountScreen().asDestination(), animated: true)
                            }
                        }
                        
                        WidgetView(title: "Weddings you'll attend", icon: .icWeddingsProfile) {
                            let vm = OtherWeddingsViewModel(otherWeddingsList: user.otherWeddings)
                            navigation.push(OtherWeddingsScreen(viewModel: vm).asDestination(),
                                            animated: true)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Settings")
                            .font(.poppinsSemiBold(size: 16))
                            .foregroundStyle(Color.mainBlack)
                            .padding(.horizontal, 16)
                        
                        WidgetView(title: "App settings", icon: .icAppSettings) {
                            navigation.push(ThemeSettingsScreen().asDestination(), animated: true)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Legal")
                            .font(.poppinsSemiBold(size: 16))
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
                            .font(.poppinsSemiBold(size: 16))
                            .foregroundStyle(Color.mainBlack)
                            .padding(.horizontal, 16)
                        
                        WidgetView(title: "App version \(viewModel.appVersion)", icon: .icAppVersion, showToggle: false) {}
                    }
                    
                    if viewModel.user == nil {
                        ClearButton(text: "Login") {
                            mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                        }
                    }
                }.padding(.top, 20)
                    .padding(.bottom, 32)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}


struct WidgetView: View {
    let title: String
    let icon: ImageResource
    var showToggle: Bool = true
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.poppinsRegular(size: 16))
                    .foregroundColor(.mainBlack)
                
                Spacer()
                
                if showToggle {
                    Image(.icItemresultArrow)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.mainBlack)
                }
            }.padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.mainPink.opacity(0.3))
                .padding(.horizontal, 16)
        }
    }
}
