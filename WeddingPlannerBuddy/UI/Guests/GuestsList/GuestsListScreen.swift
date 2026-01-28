//
//  GuestsListScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import SwiftUI

struct GuestsListScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: GuestsListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Guests list") {
                navigation.pop(animated: true)
            }
            
            if !viewModel.guestsList.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(Array(viewModel.guestsList.enumerated()), id: \.element.id) { index, guest in
                            GuestLineView(guest: guest, counter: index + 1) {
                                viewModel.openEmail(to: guest)
                            }
                        }
                    }.padding(.top, 20)
                }
            } else {
               Spacer()
               EmptyStateView(title: "No guests yet! 🎉",
                              subtitle: "Start building your guest list by inviting friends and family to celebrate together. Once you've added them, head over to the Tables Plan page to assign each guest to a seat and create the perfect arrangement! 💌✨")
               Spacer()
           }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

fileprivate struct GuestLineView: View {
    let guest: Guest
    let counter: Int
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(counter). \(guest.name)")
                        .font(.quicksandSemiBold(size: 18))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                    
                    Text(guest.email)
                        .font(.quicksandMedium(size: 16))
                        .foregroundStyle(Color.mainBlack)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 8)
                }
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(Color.nudePrimary.opacity(0.4))
            .cornerRadius(8, corners: .allCorners)
            .padding(.horizontal, 16)
        }
    }
}
