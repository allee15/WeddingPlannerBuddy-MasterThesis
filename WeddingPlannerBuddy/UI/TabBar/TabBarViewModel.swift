//
//  TabBarViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

class TabBarViewModel: ObservableObject {
    @Published var selectedTabItem: TabBarItemType
    @Published var tabBarItems: [TabBarItem]
    
    public var oldSelectedTab: TabBarItemType
    
    init() {
        self.selectedTabItem = .home
        self.oldSelectedTab = .home
        
        tabBarItems = [
            homeTabBarItem,
            weddingTabBarItem,
            guestsTabBarItem,
            mediaTabBarItem
        ]
    }
}

