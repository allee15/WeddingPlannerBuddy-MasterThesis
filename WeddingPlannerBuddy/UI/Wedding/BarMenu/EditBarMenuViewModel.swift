//
//  EditBarMenuViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 05.04.2025.
//

import Foundation
import Combine

enum EditBarState {
    case completed
    case error
}

class EditBarMenuViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var barMenu: BarMenu
    @Published var newPrice: String = ""
    @Published var newAlcool: String = ""
    @Published var newNonAlcool: String = ""
    @Published var newCoffee: String = ""
    @Published var newJuice: String = ""
    
    @Published var newAlcoolArray: [String]
    @Published var newNonalcoolArray: [String]
    @Published var newCoffeeArray: [String]
    @Published var newJuiceArray: [String]
    
    let eventSubject = PassthroughSubject<EditBarState, Never>()
    
    init(barMenu: BarMenu) {
        self.barMenu = barMenu
        self.newAlcoolArray = barMenu.alcoholic
        self.newNonalcoolArray = barMenu.nonalcoholic
        self.newJuiceArray = barMenu.juice
        self.newCoffeeArray = barMenu.coffee
    }
    
    func addNewItems() {
        if !newAlcool.isEmpty {
            self.newAlcoolArray.append(newAlcool)
        }
        
        if !newNonAlcool.isEmpty {
            self.newNonalcoolArray.append(newNonAlcool)
        }
        
        if !newCoffee.isEmpty {
            self.newCoffeeArray.append(newCoffee)
        }
        
        if !newJuice.isEmpty {
            self.newJuiceArray.append(newJuice)
        }
        
        self.editBar()
    }
    
    private func editBar() {
        let menu = BarMenu(id: barMenu.id.isEmpty ? UUID().uuidString : barMenu.id,
                           alcoholic: newAlcoolArray,
                           nonalcoholic: newNonalcoolArray,
                           coffee: newCoffeeArray,
                           juice: newJuiceArray,
                           price: newPrice.isEmpty ? barMenu.price : Int(newPrice) ?? barMenu.price)
        self.weddingService.editBarMenu(barMenu: menu)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] menu in
                guard let self else {return}
                self.barMenu = menu
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
}

