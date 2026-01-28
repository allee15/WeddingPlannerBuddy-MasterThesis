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
    @Published var newDescription: String
    @Published var newPrice: String
    @Published var newLink: String
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditBouquetState, Never>()
    
    init(groomSuit: GroomSuit) {
        self.groomSuit = groomSuit
        self.newDescription = groomSuit.description
        self.newPrice = groomSuit.price.description
        self.newLink = groomSuit.link
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editGroom() {
        let suit = GroomSuit(id: groomSuit.id.isEmpty ? UUID().uuidString : groomSuit.id,
                             link: newLink,
                             price: Int(newPrice) ?? groomSuit.price,
                             photo: groomSuit.photo,
                             description: newDescription)
        self.weddingService.editGroomSuit(groomSuit: suit, image: newImageURL)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] groomSuit in
                guard let self else {return}
                self.groomSuit = groomSuit
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
