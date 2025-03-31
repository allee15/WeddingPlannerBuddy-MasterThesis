//
//  ChooseFolderBottomSheetView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import SwiftUI

struct ChooseFolderBottomSheetView: View {
    @EnvironmentObject private var navigation: Navigation
    let googleMapsAction: () -> ()
    let appleMapsAction: () -> ()
    let wazeAction: () -> ()
    let uberAction: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 0) {
                
                Button {
                    googleMapsAction()
                } label: {
                    Text("Google Maps")
                        .font(.quicksandSemiBold(size: 20))
                        .foregroundStyle(Color.greenSecondary)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.greenSecondary.opacity(0.6))
                
                Button {
                    appleMapsAction()
                } label: {
                    Text("Maps")
                        .font(.quicksandSemiBold(size: 20))
                        .foregroundStyle(Color.greenSecondary)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.greenSecondary.opacity(0.6))
                
                Button {
                    wazeAction()
                } label: {
                    Text("Waze")
                        .font(.quicksandSemiBold(size: 20))
                        .foregroundStyle(Color.greenSecondary)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.greenSecondary.opacity(0.6))
                
                Button {
                    uberAction()
                } label: {
                    Text("Uber")
                        .font(.quicksandSemiBold(size: 20))
                        .foregroundStyle(Color.greenSecondary)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                
            }.frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8, corners: .allCorners)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            
            Button {
                navigation.dismissModal(animated: true, completion: nil)
            } label: {
                Text("Close")
                    .font(.quicksandSemiBold(size: 20))
                    .foregroundStyle(Color.greenSecondary)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
            }
            .background(Color.white)
            .cornerRadius(8, corners: .allCorners)
            .padding(.horizontal, 16)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)
            .background(Color.black.opacity(0.6))
    }
}
