//
//  HomeViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

enum TypeOfDate {
    case anytime
    case singleDate
    case periodOfTime
}

class HomeViewModel: BaseViewModel {
    @Published var selectedDateType: TypeOfDate = .anytime
    @Published var selectedDate: Date?
    @Published var selectedStartDate: Date?
    @Published var selectedEndDate: Date?
    @Published var currentDate = Date()
    @Published var startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @Published var endDate = Date()
    
    let weddingCard: HomeCard = HomeCard(title: "Start your wedding plans!",
                                         description: "We provide a wide range of tools to help you plan your dream wedding",
                                         image: .icTerms)
    let tablesCard: HomeCard = HomeCard(title: "Create the party's schema",
                                         description: "Find the best seat for every person that will attend your wedding",
                                         image: .icTerms)
    let mediaCard: HomeCard = HomeCard(title: "Keep all memories in one place",
                                       description: "You and your guests can add photos made during the wedding in the same place",
                                       image: .icTerms)
    
    func getRecommendations() {
        switch selectedDateType {
        case .anytime:
            break
            
        case .singleDate:
            break //TODO
        case .periodOfTime:
            break //TODO
        }
    }
}
