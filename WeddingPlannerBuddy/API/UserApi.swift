//
//  UserApi.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine
import SwiftyJSON

class UserApi {
    func getUser() -> AnyPublisher<User, Error> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                do {
                    promise(.success(userMocked))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func getUser() -> AnyPublisher<User, Error> {
//        Future { promise in
//            
//            let urlComponents = URLComponents(string: "\(DefaultAPIEnvironment.basePath)/api/user/get-user")
//            
//            var urlRequest = URLRequest(url: (urlComponents?.url)!)
//            
//            urlRequest.httpMethod = "GET"
//            
//            if let token = UserDefaultsService.shared.getValue(key: Key<String>(value: "jwtToken")) {
//                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            }
//            
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//                if let error = error {
//                    promise(.failure(error))
//                } else {
//                    do {
//                        let json = try JSON(data: data!)
//                        let user = JSONParsers.parseJsonUser(json: json)
//                        promise(.success(user))
//                    } catch {
//                        promise(.failure(error))
//                    }
//                }
//            }
//            dataTask.resume()
//        }.eraseToAnyPublisher()
//    }
}
