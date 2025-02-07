//
//  WeddingService.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit

class WeddingService {
    static let shared = WeddingService()
    private let weddingApi = WeddingApi()
    var bag = Set<AnyCancellable>()
    
    func startWedding(userId: String) -> AnyPublisher<Bool, Error> {
        return weddingApi.startWedding(userId: userId)
            .eraseToAnyPublisher()
    }
    
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        return weddingApi.getWeddings(userId: userId)
            .eraseToAnyPublisher()
    }
    
    func addImage(image: UIImage?) -> AnyPublisher<Bool, Error> {
        return weddingApi.addImage(image: image)
            .eraseToAnyPublisher()
    }
    
    func getWeddingDetails() -> AnyPublisher<WeddingDetails, Error> {
        return weddingApi.getWeddingDetails()
            .eraseToAnyPublisher()
    }
    
    func editWeddingDress(weddingDress: WeddingDress) -> AnyPublisher<WeddingDress, Error> {
        return weddingApi.editWeddingDress(weddingDress: weddingDress)
            .eraseToAnyPublisher()
    }
    
    func editBouquet(brideBouquet: Bouquet) -> AnyPublisher<Bouquet, Error> {
        return weddingApi.editBouquet(brideBouquet: brideBouquet)
            .eraseToAnyPublisher()
    }
    
    func editGroomSuit(groomSuit: GroomSuit) -> AnyPublisher<GroomSuit, Error> {
        return weddingApi.editGroomSuit(groomSuit: groomSuit)
            .eraseToAnyPublisher()
    }
    
    func editChurchCeremony(churchCeremony: ChurchCeremony) -> AnyPublisher<ChurchCeremony, Error> {
        return weddingApi.editChurchCeremony(churchCeremony: churchCeremony)
            .eraseToAnyPublisher()
    }
    
    func editPartyLocation(partyLocation: PartyLocation) -> AnyPublisher<PartyLocation, Error> {
        return weddingApi.editPartyLocation(partyLocation: partyLocation)
            .eraseToAnyPublisher()
    }
    
    func editCivilMarriage(civilMarriage: CivilMarriage) -> AnyPublisher<CivilMarriage, Error> {
        return weddingApi.editCivilMarriage(civilMarriage: civilMarriage)
            .eraseToAnyPublisher()
    }
    
    func editFoodMenu(foodMenu: FoodMenu) -> AnyPublisher<FoodMenu, Error> {
        return weddingApi.editFoodMenu(foodMenu: foodMenu)
            .eraseToAnyPublisher()
    }
    
    func editBarMenu(barMenu: BarMenu) -> AnyPublisher<BarMenu, Error> {
        return weddingApi.editBarMenu(barMenu: barMenu)
            .eraseToAnyPublisher()
    }
    
    func editWeddingCake(weddingCake: WeddingCake) -> AnyPublisher<WeddingCake, Error> {
        return weddingApi.editWeddingCake(weddingCake: weddingCake)
            .eraseToAnyPublisher()
    }
    
    func editLiveBand(liveBand: LiveBand) -> AnyPublisher<LiveBand, Error> {
        return weddingApi.editLiveBand(liveBand: liveBand)
            .eraseToAnyPublisher()
    }
}
