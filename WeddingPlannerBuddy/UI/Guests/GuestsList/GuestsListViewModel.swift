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
    
    init(guestsList: [Guest]) {
        self.guestsList = guestsList
    }
    
    func openEmail(to recipient: Guest) {
        let subject = "Our wedding"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //TODO: add date and location from wedding object!!!!
        let body = """
        Dear \(recipient.name),
        
        Along with our parents, we are delighted to invite you to the celebration of our love.
        
        Here you have more information about the big day.
        Date:
        Location:
        
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
