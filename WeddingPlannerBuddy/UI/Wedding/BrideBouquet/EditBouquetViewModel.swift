//
//  EditBouquetViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.04.2025.
//

import Foundation
import Combine
import UIKit

enum EditBouquetState {
    case completed
    case error
}

class EditBouquetViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var brideBouquet: Bouquet
    @Published var newDescription: String = ""
    @Published var newPrice: String = ""
    @Published var newLink: String = ""
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditBouquetState, Never>()
    
    init(brideBouquet: Bouquet) {
        self.brideBouquet = brideBouquet
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editBouquet() {
        let bouquet = Bouquet(id: brideBouquet.id,
                              link: newLink.isEmpty ? brideBouquet.link : newLink,
                              price: newPrice.isEmpty ? brideBouquet.price : Int(newPrice) ?? brideBouquet.price,
                              photo: newImageURL?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? brideBouquet.photo,
                              description: newDescription.isEmpty ? brideBouquet.description : newDescription)
        self.weddingService.editBouquet(brideBouquet: bouquet)
            .sink { _ in
                
            } receiveValue: { [weak self] brideBouquet in
                guard let self else {return}
                self.brideBouquet = brideBouquet
            }.store(in: &bag)
    }
}
