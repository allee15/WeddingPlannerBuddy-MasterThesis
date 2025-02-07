//
//  WeddingApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 26.12.2024.
//

import Foundation
import Combine
import UIKit
import SwiftyJSON

class WeddingApi {
    func startWedding(userId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/start-wedding")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "userUID": userId
            ]
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        if json["success"].boolValue {
                            promise(.success(true))
                        } else {
                            promise(.success(false))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
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
