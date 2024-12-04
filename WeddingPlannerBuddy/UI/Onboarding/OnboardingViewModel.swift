//
//  OnboardingViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

enum OnboardingState {
    case completed
    case goToTabBar
}

class OnboardingViewModel: BaseViewModel {
    var userDefaultsService = UserDefaultsService.shared
    
    @Published var pageIndex = 0
    let eventSubject = PassthroughSubject<OnboardingState, Never>()
    
    let onboardingPages: [OnboardingData] = [
        OnboardingData(image: .icHome,
                       title: "Ultimate Planner Buddy",
                       description: "Plan your dream wedding such as task lists, reminders, and more. Get suggestions based on weather conditions and your preferences!"),
        OnboardingData(image: .icHome,
                       title: "Organize your guests",
                       description: "Create plans for each table, invite your guests to see it and be prepared for the big day!"),
        OnboardingData(image: .icHome,
                       title: "All photos in one place",
                       description: "You and each guest can upload in app photos made at the wedding so that no photo will be lost!")
    ]
    
    override init() {
        super.init()
    }
    
    func nextPage() {
        if pageIndex == onboardingPages.count - 1 {
            self.userDefaultsService.setOnboarding(onboardingIsOver: true)
            self.eventSubject.send(.completed)
        } else if pageIndex < onboardingPages.count - 1 {
            pageIndex += 1
        }
    }
    
    func goToLogin() {
        self.userDefaultsService.setOnboarding(onboardingIsOver: true)
    }
}
