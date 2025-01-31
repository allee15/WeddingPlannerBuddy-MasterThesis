//
//  WeddingApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit

class WeddingApi {
    func getWeddings(userId: String) -> AnyPublisher<[Wedding], Error> {
        Future { promise in
            promise(.success(weddingsMocked))
        }.eraseToAnyPublisher()
    }
    
    func addImage(image: UIImage?) -> AnyPublisher<Bool, Error> {
        Future { promise in
            promise(.success(true))
        }.eraseToAnyPublisher()
    }
    
    func getWeddingDetails() -> AnyPublisher<WeddingDetails, Error> {
        Future { promise in
            promise(.success(weddingDetailsMocked))
        }.eraseToAnyPublisher()
    }
    
    func editWeddingDress(weddingDress: WeddingDress) -> AnyPublisher<WeddingDress, Error> {
        Future { promise in
            promise(.success(weddingdressMocked))
        }.eraseToAnyPublisher()
    }
    
    func editBouquet(brideBouquet: Bouquet) -> AnyPublisher<Bouquet, Error> {
        Future { promise in
            promise(.success(bouquetMocked))
        }.eraseToAnyPublisher()
    }
    
    func editGroomSuit(groomSuit: GroomSuit) -> AnyPublisher<GroomSuit, Error> {
        Future { promise in
            promise(.success(groomSuitMocked))
        }.eraseToAnyPublisher()
    }
    
    func editChurchCeremony(churchCeremony: ChurchCeremony) -> AnyPublisher<ChurchCeremony, Error> {
        Future { promise in
            promise(.success(churchCeremonyMocked))
        }.eraseToAnyPublisher()
    }
    
    func editPartyLocation(partyLocation: PartyLocation) -> AnyPublisher<PartyLocation, Error> {
        Future { promise in
            promise(.success(partyLocationMocked))
        }.eraseToAnyPublisher()
    }
    
    func editCivilMarriage(civilMarriage: CivilMarriage) -> AnyPublisher<CivilMarriage, Error> {
        Future { promise in
            promise(.success(civilMarriageMocked))
        }.eraseToAnyPublisher()
    }
    
    func editFoodMenu(foodMenu: FoodMenu) -> AnyPublisher<FoodMenu, Error> {
        Future { promise in
            promise(.success(foodMenuMocked))
        }.eraseToAnyPublisher()
    }
    
    func editBarMenu(barMenu: BarMenu) -> AnyPublisher<BarMenu, Error> {
        Future { promise in
            promise(.success(barMenuMocked))
        }.eraseToAnyPublisher()
    }
    
    func editWeddingCake(weddingCake: WeddingCake) -> AnyPublisher<WeddingCake, Error> {
        Future { promise in
            promise(.success(weddingCakeMocked))
        }.eraseToAnyPublisher()
    }
    
    func editLiveBand(liveBand: LiveBand) -> AnyPublisher<LiveBand, Error> {
        Future { promise in
            promise(.success(liveBandMocked))
        }.eraseToAnyPublisher()
    }
}
