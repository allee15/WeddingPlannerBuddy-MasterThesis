//
//  ApiEnvironment.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

enum DefaultAPIEnvironment {
    static private let stage = "https://wedding-planner-buddy-master-thesis-git-d29133-allees-projects.vercel.app/" //"http://localhost:8000/" 
    
    static var basePath: URL {
        let selectedEnvironment: String = {
            return stage
        }()
        return URL(string: selectedEnvironment)!
    }
}
