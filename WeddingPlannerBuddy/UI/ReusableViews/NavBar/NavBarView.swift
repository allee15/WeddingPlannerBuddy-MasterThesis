//
//  NavBarView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct NavBarView: View {
    var isCloseButton: Bool = false
    
    var body: some View {
        HStack {
            if isCloseButton {
                CloseButton()
            } else {
                BackButton()
            }
            Spacer()
        }.padding(.horizontal, 16)
    }
}
