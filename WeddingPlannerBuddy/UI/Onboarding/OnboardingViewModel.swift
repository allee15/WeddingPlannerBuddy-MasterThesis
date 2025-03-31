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
        OnboardingData(image: .imgOnboarding1,
                       title: "Wedding\nPlanner",
                       description: "Plan your perfect day with ease!  Organize every detail and enjoy a stress-free process. Let us guide you towards a flawless experience!"),
        OnboardingData(image: .imgOnboarding2,
                       title: "Your story\nbegins here",
                       description: "Every detail of your journey matters. Share your story with us, and let's make it unforgettable, together."),
        OnboardingData(image: .imgOnboarding3,
                       title: "All you need\nin one place",
                       description: "Everything you need, right at your fingertips. Simplify your planning and stay organized, all in one place.")
    ]
    
    override init() {
        super.init()
    }
    
    func nextPage() {
        if pageIndex == onboardingPages.count - 1 {
            self.userDefaultsService.setOnboarding(onboardingIsOver: true)
        } else if pageIndex < onboardingPages.count - 1 {
            pageIndex += 1
        }
    }
    
    func goToLogin() {
        self.userDefaultsService.setOnboarding(onboardingIsOver: true)
        self.eventSubject.send(.completed)
    }
    
    func goToTabBar() {
        self.userDefaultsService.setOnboarding(onboardingIsOver: true)
        self.eventSubject.send(.goToTabBar)
    }
}
