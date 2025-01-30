//
//  HomeViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import Foundation

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

class HomeViewModel: BaseViewModel {
    private let weatherService = WeatherService.shared
    @Published var locationManager = LocationManager()
    
    @Published var selectedDateType: TypeOfDate = .anytime
    @Published var selectedDate: Date?
    @Published var selectedStartDate: Date?
    @Published var selectedEndDate: Date?
    @Published var currentDate = Date()
    @Published var startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    @Published var endDate = Date()
    @Published var weatherState: WeatherState = .notStarted
    @Published var initialWeatherState: WeatherState = .notStarted
    
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
        locationManager.checkLocationAuthorization()
        
        locationManager.$lastKnownLocation.sink { [weak self] location in
            guard let self else {return}
            self.getInitialWeather()
        }.store(in: &bag)
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
        self.weatherService.getWeather(startDate: self.selectedDateType == .singleDate ? self.selectedStartDate ?? Date() : self.selectedDate ?? Date(),
                                       endDate: self.selectedEndDate,
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
    
    func resetAll() {
        self.weatherState = .notStarted
        self.selectedDateType = .anytime
        self.selectedDate = nil
        self.selectedStartDate = nil
        self.selectedEndDate = nil
    }
}
