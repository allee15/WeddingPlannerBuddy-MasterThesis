//
//  ResetPasswordEmailViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 09.12.2024.
//

import Foundation

class ResetPasswordEmailViewModel: BaseViewModel {
    var firebaseService = FirebaseService.shared
    var email: String
    
    let timerKey = "timerKey"
    let startTime = Date()
    let initialTime: Int = 120
    var timer: Timer? = nil
    
    @Published var timeRemaining: Int = 120
    
    init(email: String) {
        self.email = email
    }
    
    func startTimer() {
        UserDefaults.standard.set(startTime, forKey: timerKey)
        
        self.timeRemaining = initialTime
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    func updateTimer() {
        guard let startTime = UserDefaults.standard.object(forKey: timerKey) as? Date else { return }
        let elapsedTime = Int(Date().timeIntervalSince(startTime))
        self.timeRemaining = max(0, initialTime - elapsedTime)
    }
    
    func formattedTime() -> String {
        let minutes = timeRemaining / 60
        let remainingSeconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func resetPassword() {
        self.startTimer()
        firebaseService.resetPassword(email: email)
            .sink { _ in
                
            } receiveValue: { _ in
                
            }.store(in: &bag)
    }
}

