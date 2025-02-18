//
//  HomeViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation
import Combine

enum TypeOfDate {
    case anytime
    case singleDate
    case periodOfTime
}

enum WeatherState {
    case notStarted
    case loading
    case failure
    case value(Weather)
}

enum StartWeddingEvent {
    case showRatingModal
}

class HomeViewModel: BaseViewModel {
    private let weatherService = WeatherService.shared
    private let userService = UserService.shared
    private let weddingService = WeddingService.shared
    private let userDefaultsService = UserDefaultsService.shared
    @Published var locationManager = LocationManager()
    
    @Published var selectedDateType: TypeOfDate = .anytime
    @Published var currentDate = Date()
    @Published var startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @Published var endDate = Date()
    @Published var weatherState: WeatherState = .notStarted
    @Published var initialWeatherState: WeatherState = .notStarted
    @Published var user: User?
    
    let eventSubject = PassthroughSubject<StartWeddingEvent, Never>()
    let weddingCard: HomeCard = HomeCard(title: "Start your wedding plans!",
                                         description: "We provide a wide range of tools to help you plan your dream wedding",
                                         image: .icTerms)
    let tablesCard: HomeCard = HomeCard(title: "Create the party's schema",
                                         description: "Find the best seat for every person that will attend your wedding",
                                         image: .icTerms)
    let mediaCard: HomeCard = HomeCard(title: "Keep all memories in one place",
                                       description: "You and your guests can add photos made during the wedding in the same place",
                                       image: .icTerms)
    
    override init() {
        super.init()
        self.getUserInfo()
        locationManager.checkLocationAuthorization()
        
        locationManager.$lastKnownLocation.sink { [weak self] location in
            guard let self else {return}
            self.getInitialWeather()
        }.store(in: &bag)
    }
    
    private func getUserInfo() {
        userService.userReactiveData.getStateSubject()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] userState in
                guard let self = self else { return }
                switch userState {
                case .failure(_):
                    break
                case .loading:
                    break
                case .ready(let userState):
                    switch userState {
                    case .anonymous:
                        self.user = nil
                    case .loggedIn(let user):
                        self.user = user
                    }
                }
            }).store(in: &bag)
    }
    
    private func getInitialWeather() {
        self.initialWeatherState = .loading
        self.weatherService.getWeather(startDate: Date(),
                                       endDate: Calendar.current.date(byAdding: .day, value: +4, to: Date())!,
                                       latitude: self.locationManager.lastKnownLocation?.latitude ?? 44.4268,
                                       longitude: self.locationManager.lastKnownLocation?.longitude ?? 26.1025)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            switch completion {
            case .failure(_):
                self?.initialWeatherState = .failure
            default:
                break
            }
        } receiveValue: { [weak self] value in
            guard let self else {return}
            self.initialWeatherState = .value(value)
        }.store(in: &bag)
    }
    
    func getRecommendations() {
        self.weatherState = .loading
        self.weatherService.getWeather(startDate: self.selectedDateType == .singleDate ? self.currentDate : self.startDate,
                                       endDate: self.endDate,
                                       latitude: self.locationManager.lastKnownLocation?.latitude ?? 44.4268,
                                       longitude: self.locationManager.lastKnownLocation?.longitude ?? 26.1025)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let self else {return}
            switch completion {
            case .finished:
                break
            case .failure(_):
                self.weatherState = .failure
            }
        } receiveValue: { [weak self] value in
            guard let self else {return}
            self.weatherState = .value(value)
        }.store(in: &bag)
    }
    
    func startWedding() {
        guard let user = user else {return}
        if user.hasActiveWedding {
            //TODO: send date to API
        } else {
            weddingService.startWedding(userId: user.id) //TODO: trimite data
                .receive(on: DispatchQueue.main)
                .sink { _ in
                } receiveValue: { [weak self] result in
                    guard let self else {return}
                    if result {
                        userService.userReactiveData.reload()
                        if !userDefaultsService.getShowRateModalStatus() {
                            self.eventSubject.send(.showRatingModal)
                            userDefaultsService.setShowRateModal(hasShownRateModal: true)
                        }
                    }
                }.store(in: &bag)
        }
        TabBarCoordinator.instance.tabBarNavigation = .wedding
    }
    
    func resetAll() {
        self.weatherState = .notStarted
        self.selectedDateType = .anytime
        self.currentDate = Date()
        self.startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        self.endDate = Date()
    }
}
