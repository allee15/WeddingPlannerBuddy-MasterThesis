//
//  EditFoodMenuViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 05.04.2025.
//

import Foundation
import Combine

enum EditFoodState {
    case completed
    case error
}

class EditFoodMenuViewModel: BaseViewModel {
    private let weddingService = WeddingService.shared
    
    @Published var foodMenu: FoodMenu
    @Published var newPrice: String = ""
    @Published var newFirstCourse: String = ""
    @Published var newMainCourse: String = ""
    @Published var newSecondMainCourse: String = ""
    @Published var newAntreu: String = ""
    
    @Published var newFirstCourseArray: [String] = []
    @Published var newMainCourseArray: [String] = []
    @Published var newSecondMainCourseArray: [String] = []
    @Published var newAntreuArray: [String] = []
    
    let eventSubject = PassthroughSubject<EditFoodState, Never>()
    
    init(foodMenu: FoodMenu) {
        self.foodMenu = foodMenu
        self.newFirstCourseArray = foodMenu.firstCourse
        self.newAntreuArray = foodMenu.antreu
        self.newMainCourseArray = foodMenu.mainCourse
        self.newSecondMainCourseArray = foodMenu.secondMainCourse
    }
    
    func addNewItems() {
        if !newAntreu.isEmpty {
            self.newAntreuArray.append(newAntreu)
        }
        
        if !newFirstCourse.isEmpty {
            self.newFirstCourseArray.append(newFirstCourse)
        }
        
        if !newMainCourse.isEmpty {
            self.newMainCourseArray.append(newMainCourse)
        }
        
        if !newSecondMainCourse.isEmpty {
            self.newSecondMainCourseArray.append(newSecondMainCourse)
        }
        
        self.editFood()
    }

    
    private func editFood() {
        let menu = FoodMenu(id: foodMenu.id.isEmpty ? UUID().uuidString : foodMenu.id,
                            antreu: newAntreuArray,
                            firstCourse: newFirstCourseArray,
                            mainCourse: newMainCourseArray,
                            secondMainCourse: newSecondMainCourseArray,
                            price: newPrice.isEmpty ? foodMenu.price : Int(newPrice) ?? foodMenu.price)
        self.weddingService.editFoodMenu(foodMenu: menu)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.eventSubject.send(.error)
                default:
                    break
                }
            } receiveValue: { [weak self] menu in
                guard let self else {return}
                self.foodMenu = menu
                reloadWedding()
                self.eventSubject.send(.completed)
            }.store(in: &bag)
    }
    
    func reloadWedding() {
        weddingService.weddingReactiveData.reload()
    }
}
