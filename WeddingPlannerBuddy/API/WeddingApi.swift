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
    func editDate(date: String, weddingId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/edit-wedding-date")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "date": date,
                "weddingId": weddingId
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
    
    func startWedding(userId: String, date: String? = nil) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/start-wedding")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "userUID": userId,
                "date": date ?? ""
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
    
    func addImage(wedding: Wedding, image: UIImage) -> AnyPublisher<Wedding, Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/add-image")
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let boundary = "Boundary-\(UUID().uuidString)"
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"weddingUUID\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(wedding.weddingUUID)\r\n".data(using: .utf8)!)

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"name\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(wedding.name)\r\n".data(using: .utf8)!)

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"date\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(wedding.date)\r\n".data(using: .utf8)!)

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"location\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(wedding.location)\r\n".data(using: .utf8)!)
            
            let imagesArrayString = try? JSONEncoder().encode(wedding.images)
            if let imagesString = imagesArrayString.flatMap({ String(data: $0, encoding: .utf8) }) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"images\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(imagesString)\r\n".data(using: .utf8)!)
            }

            if let imageData = image.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }

            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            urlRequest.httpBody = body
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        if json["success"].boolValue {
                            let result = JSONParsers.parseJsonWedding(json: json["wedding"])
                            promise(.success(result))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func getWeddingDetails(userId: String) -> AnyPublisher<WeddingDetails, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/get-wedding-details")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "GET"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let weddingDetails = JSONParsers.parseJsonWeddingDetails(json: json["weddingDetails"])
                        promise(.success(weddingDetails))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editWeddingDress(weddingDress: WeddingDress, image: UIImage? = nil) -> AnyPublisher<WeddingDress, Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-wedding-dress/\(weddingDress.id)")
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let boundary = "Boundary-\(UUID().uuidString)"
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"weddingDressUUID\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(weddingDress.id)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"link\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(weddingDress.link)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"price\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(weddingDress.price)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(weddingDress.description)\r\n".data(using: .utf8)!)
            
            if let imageData = image?.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            urlRequest.httpBody = body
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let weddingDress = JSONParsers.parseJsonWeddingDress(json: json["weddingDress"])
                        promise(.success(weddingDress))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editBouquet(brideBouquet: Bouquet, image: UIImage? = nil) -> AnyPublisher<Bouquet, Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-bouquet/\(brideBouquet.id)")
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let boundary = "Boundary-\(UUID().uuidString)"
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"bouquetUUID\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(brideBouquet.id)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"link\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(brideBouquet.link)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"price\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(brideBouquet.price)\r\n".data(using: .utf8)!)
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(brideBouquet.description)\r\n".data(using: .utf8)!)
            
            if let imageData = image?.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            urlRequest.httpBody = body

            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let bouquet = JSONParsers.parseJsonBouquet(json: json["bouquet"])
                        promise(.success(bouquet))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            task.resume()
        }.eraseToAnyPublisher()
    }
    
    func editGroomSuit(groomSuit: GroomSuit, image: UIImage? = nil) -> AnyPublisher<GroomSuit, Error> {
        Future { promise in
            let boundary = "Boundary-\(UUID().uuidString)"
            guard let url = URL(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-groom-suit/\(groomSuit.id)") else {
                promise(.failure(URLError(.badURL)))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }

            var body = Data()

            let parameters: [String: String] = [
                "groomSuitUUID": groomSuit.id,
                "link": groomSuit.link,
                "price": "\(groomSuit.price)",
                "description": groomSuit.description
            ]

            for (key, value) in parameters {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }

            if let imageData = image?.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }

            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let groomSuit = JSONParsers.parseJsonGroomSuit(json: json["groomSuit"])
                        promise(.success(groomSuit))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            task.resume()
        }.eraseToAnyPublisher()
    }
    
    func editChurchCeremony(churchCeremony: ChurchCeremony) -> AnyPublisher<ChurchCeremony, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-church-ceremony/\(churchCeremony.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "churchCeremonyUUID": churchCeremony.id,
                "churchAddress": churchCeremony.churchAddress,
                "date": churchCeremony.date,
                "hour": churchCeremony.hour,
                "preotName": churchCeremony.preotName,
                "price": churchCeremony.price
            ]
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let churchCeremony = JSONParsers.parseJsonChurchCeremony(json: json["churchCeremony"])
                        promise(.success(churchCeremony))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editPartyLocation(partyLocation: PartyLocation) -> AnyPublisher<PartyLocation, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-party-location/\(partyLocation.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "partyLocationUUID": partyLocation.id,
                "partyAddress": partyLocation.partyAddress,
                "date": partyLocation.date,
                "hour": partyLocation.hour,
                "decorationsOrganizerDetails": partyLocation.decorationsOrganizerDetails,
                "price": partyLocation.price
            ]
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let partyLocation = JSONParsers.parseJsonPartyLocation(json: json["partyLocation"])
                        promise(.success(partyLocation))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editCivilMarriage(civilMarriage: CivilMarriage) -> AnyPublisher<CivilMarriage, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-civil-marriage/\(civilMarriage.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "civilMarriageUUID": civilMarriage.id,
                "address": civilMarriage.address,
                "date": civilMarriage.date,
                "hour": civilMarriage.hour
            ]
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let civilMarriage = JSONParsers.parseJsonCivilMarriage(json: json["civilMarriage"])
                        promise(.success(civilMarriage))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editFoodMenu(foodMenu: FoodMenu) -> AnyPublisher<FoodMenu, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-food-menu/\(foodMenu.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "foodMenuUUID": foodMenu.id,
                "antreu": foodMenu.antreu,
                "firstCourse": foodMenu.firstCourse,
                "mainCourse": foodMenu.mainCourse,
                "secondMainCourse": foodMenu.secondMainCourse,
                "price": foodMenu.price
            ]
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let foodMenu = JSONParsers.parseJsonFoodMenu(json: json["foodMenu"])
                        promise(.success(foodMenu))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editBarMenu(barMenu: BarMenu) -> AnyPublisher<BarMenu, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-bar-menu/\(barMenu.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "barMenuUUID": barMenu.id,
                "alcoholic": barMenu.alcoholic,
                "nonalcoholic": barMenu.nonalcoholic,
                "coffee": barMenu.coffee,
                "juice": barMenu.juice,
                "price": barMenu.price
            ]
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let barMenu = JSONParsers.parseJsonBarMenu(json: json["barMenu"])
                        promise(.success(barMenu))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
    
    func editWeddingCake(weddingCake: WeddingCake, image: UIImage? = nil) -> AnyPublisher<WeddingCake, Error> {
        Future { promise in
            let boundary = "Boundary-\(UUID().uuidString)"
            guard let url = URL(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-wedding-cake/\(weddingCake.id)") else {
                promise(.failure(URLError(.badURL)))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }

            var body = Data()

            let parameters: [String: String] = [
                "weddingCakeUUID": weddingCake.id,
                "name": weddingCake.name,
                "price": "\(weddingCake.price)",
                "description": weddingCake.description
            ]

            for (key, value) in parameters {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }

            if let imageData = image?.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }

            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let cake = JSONParsers.parseJsonWeddingCake(json: json["weddingCake"])
                        promise(.success(cake))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            task.resume()
        }.eraseToAnyPublisher()
    }
    
    func editLiveBand(liveBand: LiveBand) -> AnyPublisher<LiveBand, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/wedding/update-live-band/\(liveBand.id)")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let body: [String: Any] = [
                "liveBandUUID": liveBand.id,
                "name": liveBand.name,
                "price": liveBand.price,
                "hour": liveBand.hour,
                "details": liveBand.details
            ]
            
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    do {
                        let json = try JSON(data: data!)
                        let liveBand = JSONParsers.parseJsonLiveBand(json: json["liveBand"])
                        promise(.success(liveBand))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
            dataTask.resume()
        }.eraseToAnyPublisher()
    }
}
