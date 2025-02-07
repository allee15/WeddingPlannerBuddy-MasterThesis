//
//  ApiEnvironment.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

enum DefaultAPIEnvironment {
    static private let stage = "https://wedding-planner-buddy-master-thesis.vercel.app/" //"http://localhost:8000/" //"https://wedding-planner-buddy-master-thesis.vercel.app/"
    
    static var basePath: URL {
        let selectedEnvironment: String = {
            return stage
        }()
        return URL(string: selectedEnvironment)!
    }
}
