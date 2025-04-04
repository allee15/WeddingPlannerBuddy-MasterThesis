//
//  EditGroomViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditGroomState {
    case completed
    case error
}

class EditGroomViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var groomSuit: GroomSuit
    @Published var newDescription: String = ""
    @Published var newPrice: String = ""
    @Published var newLink: String = ""
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditBouquetState, Never>()
    
    init(groomSuit: GroomSuit) {
        self.groomSuit = groomSuit
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editGroom() {
        let suit = GroomSuit(id: groomSuit.id.isEmpty ? UUID().uuidString : groomSuit.id,
                             link: newLink.isEmpty ? groomSuit.link : newLink,
                             price: newPrice.isEmpty ? groomSuit.price : Int(newPrice) ?? groomSuit.price,
                             photo: newImageURL?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? groomSuit.photo,
                             description: newDescription.isEmpty ? groomSuit.description : newDescription)
        self.weddingService.editGroomSuit(groomSuit: suit)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] groomSuit in
                guard let self else {return}
                self.groomSuit = groomSuit
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
}
