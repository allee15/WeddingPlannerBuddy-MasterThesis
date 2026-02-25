//
//  AddParticipantViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 11.12.2024.
//

import Foundation
import Combine
import UIKit

enum AddParticipantEvent {
    case completed
    case error
}

enum ProfileField {
    case name
    case email
}

class AddParticipantViewModel: BaseViewModel {
    private var tablesService = TablesService.shared
    private var userService = UserService.shared
    private let weddingService = WeddingService.shared
    
    @Published var weddingDate: String = ""
    @Published var weddingChurchLocation: String = ""
    @Published var weddingPartyLocation: String = ""
    @Published var name: String = ""
    @Published var email: String = ""
    var userId: String
    var tableId: String
    
    let eventSubject = PassthroughSubject<AddParticipantEvent, Never>()
    
    init(userId: String, tableId: String) {
        self.userId = userId
        self.tableId = tableId
        super.init()
        self.getWeddingDetails()
    }
    
    func hasChanges() -> Bool {
        return !name.isEmpty && !email.isEmpty && email.isValidEmail()
    }
    
    func addParticipant() {
        let guest = Guest(id: UUID().uuidString, name: name, email: email, tableUID: tableId)
        tablesService.addParticipant(participant: guest, userId: userId, tableUUID: tableId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    self.eventSubject.send(.error)
                }
            } receiveValue: { [weak self] result in
                guard let self else {return}
                if result {
                    userService.userReactiveData.reload()
                    openEmail(to: guest)
                    eventSubject.send(.completed)
                } else {
                    eventSubject.send(.error)
                }
            }.store(in: &bag)
    }
    
    private func openEmail(to recipient: Guest) {
        let subject = "Our wedding"
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let guestDetails = self.getGuestDetails(guestId: recipient.id)
        let email = guestDetails?.email ?? "unknown@example.com"
        let password = guestDetails?.password ?? "N/A"
        
        let body = """
        Dear \(recipient.name),
        
        Along with our parents, we are delighted to invite you to the celebration of our love.
        
        Here you have more information about the big day.
        Date: \(self.weddingDate)
        Church location: \(self.weddingChurchLocation)
        Party location: \(self.weddingPartyLocation)
        Here you'll find your account details, in order to authenticate into the app:
        Email: \(email)
        Password: \(password)
        
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
    
    private func getGuestDetails(guestId: String) -> (email: String, password: String)? {
        if let guest = tablesService.newGuests.first(where: { $0.id == guestId }) {
            return (guest.email, guest.password)
        }
        return nil
    }
    
    private func getWeddingDetails() {
        self.weddingService.weddingReactiveData.getStateSubject()
            .sink { _ in
                
            } receiveValue: { [weak self] weddingDetails in
                guard let self else {return}
                
                switch weddingDetails {
                case .failure(_):
                    break
                case .loading:
                    break
                case .ready(let details):
                    self.weddingDate = details.date
                    self.weddingPartyLocation = details.partyLocation.partyAddress
                    self.weddingChurchLocation = details.churchCeremony.churchAddress
                }
            }.store(in: &bag)
    }
}
