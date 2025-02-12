//
//  ApiEnvironment.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

enum DefaultAPIEnvironment {
    static private let stage = "http://localhost:8000/" 
    
    static var basePath: URL {
        let selectedEnvironment: String = {
            return stage
        }()
        return URL(string: selectedEnvironment)!
    }
}
