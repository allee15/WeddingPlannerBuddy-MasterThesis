//
//  GuestsListViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine
import UIKit

class GuestsListViewModel: BaseViewModel {
    @Published var guestsList: [Guest] = []
    @Published var weddingDate: String
    @Published var weddingChurchLocation: String
    @Published var weddingPartyLocation: String
    
    init(guestsList: [Guest], weddingDate: String, weddingChurchLocation: String, weddingPartyLocation: String) {
        self.guestsList = guestsList
        self.weddingDate = weddingDate
        self.weddingChurchLocation = weddingChurchLocation
        self.weddingPartyLocation = weddingPartyLocation
    }
    
    func openEmail(to recipient: Guest) {
        let subject = "Our wedding"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let body = """
        Dear \(recipient.name),
        
        Along with our parents, we are delighted to invite you to the celebration of our love.
        
        Here you have more information about the big day.
        Date: \(self.weddingDate)
        Church location: \(self.weddingChurchLocation)
        Party location: \(self.weddingPartyLocation)
        
        If you want to keep this information stored in one place, you can download the app "Wedding Planner Buddy".
        
        Warm regards,
        The Bride and the Groom
        """
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "mailto:\(recipient.email)?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Unable to open email client.")
        }
    }
}
