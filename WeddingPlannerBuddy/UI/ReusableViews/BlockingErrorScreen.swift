//
//  BlockingErrorScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct BlockingErrorScreen: View {
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("An error has occured")
                .foregroundColor(.black)
                .font(.quicksandSemiBold(size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
            
            Text("There has been an error retrieving data from the server. Please check your internet connection and try again. If the problem persists, please contact us.")
                .foregroundColor(.black)
                .font(.quicksandRegular(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainWhite)
            .safeAreaInset(edge: .bottom) {
                MainButtonView(text: "Retry") {
                    action()
                }.padding([.bottom, .horizontal], 16)
            }
    }
}
