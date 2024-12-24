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
                        .font(.poppinsRegular(size: 14))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.gray.opacity(0.4))
                
                Button {
                    appleMapsAction()
                } label: {
                    Text("Maps")
                        .font(.poppinsRegular(size: 14))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.gray.opacity(0.4))
                
                Button {
                    wazeAction()
                } label: {
                    Text("Waze")
                        .font(.poppinsRegular(size: 14))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.gray.opacity(0.4))
                
                Button {
                    uberAction()
                } label: {
                    Text("Uber")
                        .font(.poppinsRegular(size: 14))
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity)
                
            }.frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8, corners: .allCorners)
                .border(Color.gray.opacity(0.4), width: 1, cornerRadius: 8)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                .padding(.top, 1)
            
            Button {
                navigation.dismissModal(animated: true, completion: nil)
            } label: {
                Text("Închide")
                    .font(.poppinsRegular(size: 14))
                    .frame(maxWidth: .infinity)
            }.padding(.vertical, 16)
                .background(Color.white)
                .cornerRadius(8, corners: .allCorners)
                .border(Color.gray.opacity(0.4), width: 1, cornerRadius: 8)
                .padding(.horizontal, 16)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 24)
            .background(Color.black.opacity(0.6))
    }
}
