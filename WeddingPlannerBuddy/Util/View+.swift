//
//  View+.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI
import UIKit

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    
    func borderWithShadow(borderColor: Color, width: CGFloat, cornerRadius: CGFloat, fillColor: Color, shadowColor: Color, shadowRadius: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
                .shadow(color: shadowColor, radius: shadowRadius, x: x, y: y))
        .border(borderColor, width: width, cornerRadius: cornerRadius)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func snapshot(completion: @escaping (UIImage?) -> Void) {
        let controller = UIHostingController(rootView: self)
        controller.view.backgroundColor = .clear
        
        let targetSize = controller.view.intrinsicContentSize
        controller.view.bounds = CGRect(origin: .zero, size: targetSize)
        controller.view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let image = renderer.image { _ in
                controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            }
            completion(image)
        }
    }
}
