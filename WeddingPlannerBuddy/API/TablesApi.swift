//
//  TablesApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 24.12.2024.
//

import Foundation
import Combine
import SwiftyJSON

class TablesApi {
    func addTable(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/table/add-table")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let positionJSON: [String: Any] = [
                "x": table.position.x,
                "y": table.position.y
            ]
            
            let participantsJSON = table.participants.map { [
                "userUID": userId,
                "tableUID": $0.id,
                "name": $0.name,
                "email": $0.email
            ]}
            
            let body: [String: Any] = [
                "userUID": userId,
                "tableUID": table.id,
                "position": positionJSON,
                "label": table.label,
                "participants": participantsJSON,
                "isObject": table.isObject
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
    
    func addRectangle(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/table/add-rectangle")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let positionJSON: [String: Any] = [
                "x": table.position.x,
                "y": table.position.y
            ]
            
            let participantsJSON = table.participants.map { [
                "userUID": userId,
                "tableUID": $0.id,
                "name": $0.name,
                "email": $0.email
            ]}
            
            let body: [String: Any] = [
                "userUID": userId,
                "tableUID": table.id,
                "position": positionJSON,
                "label": table.label,
                "participants": participantsJSON,
                "isObject": table.isObject
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
    
    func addParticipant(participant: Guest, userId: String, tableId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/table/add-guest")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }

            let body: [String: Any] = [
                "guestUUID": participant.id,
                "userUID": userId,
                "tableUID": tableId,
                "name": participant.name,
                "email": participant.email
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
    
    func updateTablePosition(table: Table, userId: String) -> AnyPublisher<Bool, Error> {
        Future { promise in
            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)api/table/update-position")
            
            var urlRequest = URLRequest(url: (urlComponents?.url)!)
            urlRequest.httpMethod = "POST"
            
            if let token = UserDefaultsService.shared.getValue(key: UserDefaultsKeys.token) {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            let positionJSON: [String: Any] = [
                "x": table.position.x,
                "y": table.position.y
            ]
            
            let body: [String: Any] = [
                "userUID": userId,
                "tableUID": table.id,
                "position": positionJSON
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

}
