//
//  WeddingDressScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 30.01.2025.
//

import SwiftUI

struct BrideBouquetScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: BrideBouquetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Bride's bouquet") {
                navigation.pop(animated: true)
            }
            
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    LoaderView()
                    Spacer()
                }.padding(.horizontal, 16)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.brideBouquet.id)
                        Button {
                            let new = Bouquet(id: viewModel.brideBouquet.id,
                                              link: "",
                                              price: 23,
                                              photo: "",
                                              description: "wfferfgsersfgdds")
                            viewModel.editBouquet(new)
                        } label: {
                            Text("Edit")
                        }
                        Text(viewModel.brideBouquet.description)
                    }.padding(.top, 24)
                        .padding(.horizontal, 16)
                }  
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}
