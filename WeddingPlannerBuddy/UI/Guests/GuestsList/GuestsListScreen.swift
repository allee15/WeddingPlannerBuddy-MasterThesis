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
            LeftNavBarView(title: "Weddings you'll attend") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    if !viewModel.guestsList.isEmpty {
                        ForEach(Array(viewModel.guestsList.enumerated()), id: \.element.id) { index, guest in
                            GuestLineView(guest: guest, counter: index + 1) {
                                viewModel.openEmail(to: guest)
                            }
                        }
                    } else {
                        HStack {
                            Text("You do not have any guests coming at your wedding for the moment.")
                                .foregroundStyle(Color.mainBlack)
                                .font(.poppinsRegular(size: 16))
                                .padding(.horizontal, 16)
                            
                            Spacer()
                        }
                        Spacer()
                    }
                }.padding(.top, 32)
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
            VStack(alignment: .leading, spacing: 8) {
                Text("\(counter). \(guest.name), email: \(guest.email)")
                    .font(.poppinsRegular(size: 16))
                    .foregroundStyle(Color.mainBlack)
                
                DividerView()
            }.padding(.horizontal, 16)
        }
    }
}
