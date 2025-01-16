//
//  HomeViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

class HomeViewModel: BaseViewModel {
    let weddingCard: HomeCard = HomeCard(title: "Start your wedding plans!",
                                         description: "We provide a wide range of tools to help you plan your dream wedding",
                                         image: .icTerms)
    let tablesCard: HomeCard = HomeCard(title: "Create the party's schema",
                                         description: "Find the best seat for every person that will attend your wedding",
                                         image: .icTerms)
    let mediaCard: HomeCard = HomeCard(title: "Keep all memories in one place",
                                       description: "You and your guests can add photos made during the wedding in the same place",
                                       image: .icTerms)
}
