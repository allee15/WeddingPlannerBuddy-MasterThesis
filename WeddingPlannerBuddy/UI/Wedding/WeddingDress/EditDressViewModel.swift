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
    @Published var newDescription: String
    @Published var newPrice: String
    @Published var newLink: String
    @Published var newImageURL: UIImage?
    
    let eventSubject = PassthroughSubject<EditDressState, Never>()
    
    init(weddingDress: WeddingDress) {
        self.weddingDress = weddingDress
        self.newDescription = weddingDress.description
        self.newPrice = weddingDress.price.description
        self.newLink = weddingDress.link
    }
    
    func addImage(image: UIImage?) {
        guard let image = image else {return}
        self.newImageURL = image
    }
    
    func editDress() {
        let dress = WeddingDress(id: weddingDress.id.isEmpty ? UUID().uuidString : weddingDress.id,
                                 link: newLink,
                                 price: Int(newPrice) ?? weddingDress.price,
                                 photo: weddingDress.photo,
                                 description: newDescription)
        
        self.weddingService.editWeddingDress(weddingDress: dress, image: newImageURL)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] weddingDress in
                guard let self else {return}
                self.weddingDress = weddingDress
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
