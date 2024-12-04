//
//  DividerView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(Color.mainPink)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    DividerView()
}
