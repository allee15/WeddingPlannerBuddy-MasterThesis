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
                               photo: weddingCake.photo,
                               description: newDescription.isEmpty ? weddingCake.description : newDescription,
                               price: newPrice.isEmpty ? weddingCake.price : Int(newPrice) ?? weddingCake.price)
        self.weddingService.editWeddingCake(weddingCake: cake, image: newImageURL)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] weddingCake in
                guard let self else {return}
                self.weddingCake = weddingCake
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
