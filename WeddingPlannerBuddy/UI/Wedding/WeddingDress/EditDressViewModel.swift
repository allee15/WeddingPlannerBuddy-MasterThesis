//
//  EditDressViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditDressState {
    case completed
    case error
}

class EditDressViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var weddingDress: WeddingDress
    @Published var newDescription: String = ""
    @Published var newPrice: String = ""
    @Published var newLink: String = ""
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditDressState, Never>()
    
    init(weddingDress: WeddingDress) {
        self.weddingDress = weddingDress
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editDress() {
        let dress = WeddingDress(id: weddingDress.id,
                                 link: newLink.isEmpty ? weddingDress.link : newLink,
                                 price: newPrice.isEmpty ? weddingDress.price : Int(newLink) ?? weddingDress.price,
                                 photo: newImageURL?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? weddingDress.photo,
                                 description: newDescription.isEmpty ? weddingDress.description : newDescription)
        self.weddingService.editWeddingDress(weddingDress: dress)
            .sink { _ in
                
            } receiveValue: { [weak self] weddingDress in
                guard let self else {return}
                self.weddingDress = weddingDress
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
}
