//
//  TabBarViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

@Observable
class TabBarViewModel {
    var selectedTabItem: TabBarItemType
    var tabBarItems: [TabBarItem]
    
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

