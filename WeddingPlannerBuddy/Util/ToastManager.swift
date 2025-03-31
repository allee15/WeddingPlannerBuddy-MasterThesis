//
//  ToastManager.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

class ToastManager: ObservableObject {
    
    static let instance = ToastManager()
    
    @Published private(set) var toast: Toast?
    
    var timer: Timer?
    
    func show(_ toast: Toast) {
        self.toast = toast
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: toast.timeInterval, repeats: false, block: { [weak self] timer in
            timer.invalidate()
            self?.toast = nil
        })
    }
    
    func hideToast() {
        toast = nil
    }
}

struct Toast: Equatable {
    
    private let id = UUID().uuidString
    
    let text: String
    var textColor: Color = Color.greenTertiary
    var bg: Color = Color.lightGreen
    var icon: ImageResource = .icToastGreen
    var timeInterval: TimeInterval = 2
    
    static func ==(lhs: Toast, rhs: Toast) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ToastView: View {
    
    let toast: Toast
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(toast.icon)
                .resizable()
                .frame(width: 24, height: 30)
            
            Text(toast.text)
                .font(.quicksandSemiBold(size: 14))
                .foregroundColor(toast.textColor)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(toast.bg)
        .cornerRadius(4)
        .padding(.horizontal, 20)
    }
}
