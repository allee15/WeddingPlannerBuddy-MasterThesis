//
//  TabBarScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

enum TabBarNavigation {
    case home
    case wedding
    case guests
    case media
}

class TabBarCoordinator: ObservableObject {
    static let instance = TabBarCoordinator()
    @Published var tabBarNavigation: TabBarNavigation?
}

struct TabBarScreen: View {
    @EnvironmentObject private var navigation: Navigation
    
    @ObservedObject private var tabBarCoordinator = TabBarCoordinator.instance
    @State private var viewModel = TabBarViewModel()
    
    @StateObject private var homeNavigation = Navigation(root: HomeScreen().asDestination())
    @StateObject private var weddingNavigation = Navigation(root: WeddingScreen().asDestination())
    @StateObject private var guestsNavigation = Navigation(root: GuestsScreen().asDestination())
    @StateObject private var mediaNavigation = Navigation(root: MediaScreen().asDestination())
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { proxy in
                LazyHStack(spacing: 0) {
                    Group {
                        switch viewModel.selectedTabItem {
                        case .home:
                            NavigationHostView(navigation: homeNavigation)
                        case .wedding:
                            NavigationHostView(navigation: weddingNavigation)
                        case .guests:
                            NavigationHostView(navigation: guestsNavigation)
                        case .media:
                            NavigationHostView(navigation: mediaNavigation)
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height)
                }.onChange(of: viewModel.selectedTabItem) { _, newValue in
                    homeNavigation.popToRoot(animated: false)
                    weddingNavigation.popToRoot(animated: false)
                    guestsNavigation.popToRoot(animated: false)
                    mediaNavigation.popToRoot(animated: false)
                    self.viewModel.oldSelectedTab = newValue
                }.onReceive(tabBarCoordinator.$tabBarNavigation, perform: { value in
                    if let value {
                        switch value {
                        case .home:
                            if viewModel.selectedTabItem != .home {
                                viewModel.selectedTabItem = .home
                            }
                            homeNavigation.popToRoot(animated: true)
                        case .wedding:
                            if viewModel.selectedTabItem != .wedding {
                                viewModel.selectedTabItem = .wedding
                            }
                            weddingNavigation.popToRoot(animated: true)
                        case .guests:
                            if viewModel.selectedTabItem != .guests {
                                viewModel.selectedTabItem = .guests
                            }
                            guestsNavigation.popToRoot(animated: true)
                        case .media:
                            if viewModel.selectedTabItem != .media {
                                viewModel.selectedTabItem = .media
                            }
                            mediaNavigation.popToRoot(animated: true)
                        }
                    }
                })
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainWhite)
        .ignoresSafeArea(.container)
        .ignoresSafeArea(.keyboard)
        .safeAreaInset(edge: .bottom) {
            TabBarView(
                selectedItem: $viewModel.selectedTabItem,
                items: viewModel.tabBarItems
            )
        }
    }
}
