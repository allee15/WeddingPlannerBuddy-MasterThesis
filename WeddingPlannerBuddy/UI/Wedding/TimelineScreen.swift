//
//  TimelineScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 18.01.2026.
//

import SwiftUI

struct TimelineScreen: View {
    @EnvironmentObject private var navigation: Navigation
    
    let items: [ScheduleItem]
    let weddingDate: String
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Wedding timeline") {
                navigation.pop(animated: true)
            }
            
            if items.isEmpty {
                Spacer()
                EmptyStateView(title: "No details Yet",
                               subtitle: "Start adding important information to make your big day unforgettable! 🎉")
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                            TimelineRowView(item: item, weddingDate: weddingDate, isLast: index == items.count - 1)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .background(Color.mainWhite)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
        .safeAreaInset(edge: .bottom) {
            MainButtonView(text: "Export Timeline") {
                TimelineExportView(items: items, weddingDate: weddingDate)
                    .snapshot { image in
                        guard let image else { return }
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        print("Timeline complet exportat ca PNG!")
                    }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }
}

fileprivate struct TimelineIndicatorView: View {
    let isLast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(Color.greenSecondary)
                .frame(width: 28, height: 28)
            
            if !isLast {
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color.greenSecondary)
                        .frame(width: 2, height: geo.size.height * 4)
                        .position(x: 1, y: geo.size.height * 1.5)
                }
                .frame(width: 2)
            }
        }
        .frame(width: 16)
    }
}

fileprivate struct TimelineCardView: View {
    
    let item: ScheduleItem
    let weddingDate: String
    
    var body: some View {
        HStack {
            Text(item.displayText(fallbackDate: weddingDate))
                .foregroundStyle(Color.mainBlack)
                .font(.quicksandBold(size: 16))
            
            Spacer()
        }
    }
}

fileprivate struct TimelineRowView: View {
    
    let item: ScheduleItem
    let weddingDate: String
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            TimelineIndicatorView(isLast: isLast)
            
            TimelineCardView(item: item, weddingDate: weddingDate)
        }
        .padding(.all, 12)
    }
}

fileprivate struct TimelineExportView: View {
    let items: [ScheduleItem]
    let weddingDate: String
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                TimelineRowView(
                    item: item,
                    weddingDate: weddingDate,
                    isLast: index == items.count - 1
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color.mainWhite)
    }
}
