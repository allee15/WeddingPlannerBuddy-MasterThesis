//
//  DividerView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct DividerView: View {
    let color: Color
    var body: some View {
        Rectangle()
            .foregroundStyle(color)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
}
