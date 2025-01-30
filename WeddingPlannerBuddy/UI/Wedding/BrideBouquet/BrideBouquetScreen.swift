//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct BrideBouquetScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = BrideBouquetViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Bride's bouquet") {
                navigation.pop(animated: true)
            }
            
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

#Preview {
    BrideBouquetScreen()
}
