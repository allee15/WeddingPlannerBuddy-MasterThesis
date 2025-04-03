//
//  EditCakeViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditCakeState {
    case completed
    case error
}

class EditCakeViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var weddingCake: WeddingCake
    @Published var newDescription: String = ""
    @Published var newPrice: String = ""
    @Published var newName: String = ""
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditCakeState, Never>()
    
    init(weddingCake: WeddingCake) {
        self.weddingCake = weddingCake
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editCake() {
        let cake = WeddingCake(id: weddingCake.id.isEmpty ? UUID().uuidString : weddingCake.id,
                               name: newName.isEmpty ? weddingCake.name : newName,
                               photo: newImageURL?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? weddingCake.photo,
                               description: newDescription.isEmpty ? weddingCake.description : newDescription,
                               price: newPrice.isEmpty ? weddingCake.price : Int(newPrice) ?? weddingCake.price)
        self.weddingService.editWeddingCake(weddingCake: cake)
            .sink { _ in
                
            } receiveValue: { [weak self] weddingCake in
                guard let self else {return}
                self.weddingCake = weddingCake
            }.store(in: &bag)
    }
}
