//
//  TabBarItem.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import SwiftUI

enum TabBarItemType: Equatable {
    case home
    case wedding
    case guests
    case media
}

struct TabBarItem {
    let type: TabBarItemType
    let title: String
    let imageName: ImageResource
}

let homeTabBarItem = TabBarItem(
    type: .home,
    title: "Home",
    imageName: .icHome
)

let weddingTabBarItem = TabBarItem(
    type: .wedding,
    title: "Wedding",
    imageName: .icWedding
)

let guestsTabBarItem = TabBarItem(
    type: .guests,
    title: "Guests",
    imageName: .icGuests
)

let mediaTabBarItem = TabBarItem(
    type: .media,
    title: "Media",
    imageName: .icMedia
)

struct TabBarItemView: View {
    let tabBarItem: TabBarItem
    let isSelected: Bool
    let selectAction: (TabBarItem) -> ()
    
    var body: some View {
        Button {
            selectAction(tabBarItem)
        } label: {
            VStack(spacing: 4) {
                Image(tabBarItem.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(isSelected ? .greenSecondary : Color.mainBlack.opacity(0.8))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                
                Text(tabBarItem.title)
                    .font(.quicksandMedium(size: 12))
                    .foregroundColor(isSelected ? .greenSecondary : Color.mainBlack.opacity(0.8))
            }
        }
    }
}

struct TabBarView: View {
    @Binding var selectedItem: TabBarItemType
    let items: [TabBarItem]
    
    var body: some View {
        HStack {
            ForEach(items, id: \.type) { item in
                TabBarItemView(
                    tabBarItem: item,
                    isSelected: selectedItem == item.type) { tabBarItem in
                        self.selectedItem = item.type
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, SafeAreaInsets.bottom > 0 ? 0 : 4)
            }
        }.frame(maxWidth: .infinity)
            .frame(height: 46)
            .padding(.bottom, SafeAreaInsets.bottom)
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .background(Color.mainWhite)
    }
}
