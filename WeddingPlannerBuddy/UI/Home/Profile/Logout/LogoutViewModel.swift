//
//  LogoutViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 31.03.2025.
//

import Foundation
import Combine

class LogoutViewModel: BaseViewModel {
    var userService = UserService.shared
    
    func logOut() {
        userService.logout()
    }
}
