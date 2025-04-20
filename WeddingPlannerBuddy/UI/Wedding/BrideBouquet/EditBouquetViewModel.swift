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
        let bouquet = Bouquet(id: brideBouquet.id.isEmpty ? UUID().uuidString : brideBouquet.id,
                              link: newLink.isEmpty ? brideBouquet.link : newLink,
                              price: newPrice.isEmpty ? brideBouquet.price : Int(newPrice) ?? brideBouquet.price,
                              photo: brideBouquet.photo,
                              description: newDescription.isEmpty ? brideBouquet.description : newDescription)
        self.weddingService.editBouquet(brideBouquet: bouquet, image: newImageURL)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] brideBouquet in
                guard let self else {return}
                self.brideBouquet = brideBouquet
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
