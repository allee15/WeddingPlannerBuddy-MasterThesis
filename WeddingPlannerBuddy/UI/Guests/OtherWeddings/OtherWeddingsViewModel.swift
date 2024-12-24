//
//  OtherWeddingsViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine
import UIKit

class OtherWeddingsViewModel: BaseViewModel {
    @Published var otherWeddingsList: [WeddingGuest] = []
    
    init(otherWeddingsList: [WeddingGuest]) {
        self.otherWeddingsList = otherWeddingsList
    }
    
    func openAppleMaps(for address: String) {
        let urlString = "http://maps.apple.com/?address=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    func openGoogleMaps(for address: String) {
        if let url = URL(string: "comgooglemaps://?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let url = URL(string: "https://maps.google.com/?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }

    func openWaze(for address: String) {
        if let url = URL(string: "waze://?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let url = URL(string: "https://waze.com/ul?q=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }

    func openUber(for address: String) {
        if let url = URL(string: "uber://?action=setPickup&dropoff[formatted_address]=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let url = URL(string: "https://m.uber.com/ul/?action=setPickup&dropoff[formatted_address]=\(address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            UIApplication.shared.open(url)
        }
    }
}
