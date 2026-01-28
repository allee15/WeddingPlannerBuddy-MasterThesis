//
//  HomeScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    private let mainNavigation = EnvironmentObjects.navigation
    @StateObject private var viewModel = HomeViewModel()
    
    @State var showDatePicker: Bool = false
    @State var showStartDate: Bool = false
    @State var showEndDate: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Home",
                           hasBackButton: false,
                           rightButtonIcon: .icMenu) {
                
            } rightButtonAction: {
                mainNavigation?.push(ProfileScreen().asDestination(), animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pick the perfect wedding day! 🌤️💍")
                            .font(.quicksandBold(size: 18))
                            .foregroundStyle(Color.mainBlack)
                            .multilineTextAlignment(.leading)
                        
                        Text("Select a fixed date or a time range, and we’ll provide weather predictions to help you plan with confidence.")
                            .font(.quicksandMedium(size: 16))
                            .foregroundStyle(Color.mainBlack)
                            .multilineTextAlignment(.leading)
                    }.padding(.horizontal, 16)
                    
                    HStack(spacing: 13) {
                        PeriodOfTimeFilterButtonView(text: "Anytime",
                                                     dateType: .anytime,
                                                     selectedDateType: viewModel.selectedDateType) {
                            viewModel.selectedDateType = .anytime
                            viewModel.weatherState = .notStarted
                        }
                        
                        PeriodOfTimeFilterButtonView(text: "One day",
                                                    dateType: .singleDate,
                                                    selectedDateType: viewModel.selectedDateType) {
                            viewModel.selectedDateType = .singleDate
                            viewModel.weatherState = .notStarted
                        }
                        
                        PeriodOfTimeFilterButtonView(text: "A period",
                                                    dateType: .periodOfTime,
                                                    selectedDateType: viewModel.selectedDateType) {
                            viewModel.selectedDateType = .periodOfTime
                            viewModel.weatherState = .notStarted
                        }

                        Spacer()
                    }.padding(.horizontal, 16)
                    
                    switch viewModel.weatherState {
                    case .notStarted:
                        
                        if viewModel.selectedDateType == .singleDate {
                            VStack(spacing: 0) {
                                DateView(
                                    placeHolder: "Select date",
                                    date: $viewModel.currentDate,
                                    singleDateSelected: viewModel.currentDate) {
                                        showDatePicker = true
                                    }.background(Color.nudePrimary.opacity(0.5))
                                    .cornerRadius(8, corners: [.topLeft, .topRight])
                                    .padding(.top, 16)
                                
                                DividerView(color: Color.nudePrimary)
                                
                                DatePicker("", selection: $viewModel.currentDate,
                                           in: (Date())..., displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .accentColor(Color.greenSecondary)
                                    .background(Color.nudePrimary.opacity(0.35))
                                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                            }.padding(.horizontal, 16)
                            
                            MainButtonView(text: "Get recommendations") {
                                viewModel.getRecommendations()
                            }.padding(.horizontal, 16)
                        }
                        
                        if viewModel.selectedDateType == .periodOfTime {
                            VStack(spacing: 0) {
                                DateView(
                                    placeHolder: "From date",
                                    date: $viewModel.startDate,
                                    selectedStartDate: viewModel.startDate) {
                                        withAnimation {
                                            showStartDate = true
                                            showEndDate = false
                                        }
                                    }
                                    .background(Color.nudePrimary.opacity(0.5))
                                    .cornerRadius(8, corners: [.topLeft, .topRight])
                                
                                if showStartDate == true {
                                    DividerView(color: Color.nudePrimary)
                                    
                                    DatePicker("", selection: $viewModel.startDate, in: (Date())..., displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .accentColor(Color.greenSecondary)
                                        .background(Color.nudePrimary.opacity(0.35))
                                        .transition(.opacity)
                                }
                                
                                DividerView(color: Color.nudePrimary)
                                
                                DateView(
                                    placeHolder: "To date",
                                    date: $viewModel.endDate,
                                    selectedEndDate: viewModel.endDate) {
                                        withAnimation {
                                            showEndDate = true
                                            showStartDate = false
                                        }
                                    }
                                    .background(Color.nudePrimary.opacity(0.5))
                                    .cornerRadius(8, corners: showStartDate == true ? [.bottomLeft, .bottomRight] : [])
                                
                                if showEndDate == true {
                                    DividerView(color: Color.nudePrimary)
                                    
                                    DatePicker("", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .accentColor(Color.greenSecondary)
                                        .background(Color.nudePrimary.opacity(0.35))
                                        .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                                        .transition(.opacity)
                                }
                            }.padding(.horizontal, 16)
                            
                            MainButtonView(text: "Get recommendations") {
                                viewModel.getRecommendations()
                            }.padding(.horizontal, 16)
                        }
                        
                        switch viewModel.initialWeatherState {
                        case .notStarted:
                            EmptyView()
                        case .loading:
                            HStack {
                                Spacer()
                                LoaderView(height: 40, width: 40)
                                Spacer()
                            }.padding(.horizontal, 16)
                            
                        case .failure:
                            EmptyView()
                            
                        case .value(let weatherArray):
                            if !weatherArray.isEmpty {
                                if weatherArray.count == 1 || viewModel.selectedDateType == .singleDate {
                                    WeatherCardView(prediction: weatherArray[0].prediction, date: weatherArray[0].date) {
                                        if let user = viewModel.user {
                                            let modal = ModalChooseOptionView(title: "Change wedding date",
                                                                              description: "Are you sure you want to select this date? This action will change your wedding date.",
                                                                              topButtonText: "Continue",
                                                                              bottomButtonText: "Back") {
                                                viewModel.startWedding(date: weatherArray[0].date)
                                            } onBottomButtonTapped: {
                                                navigation.dismissModal(animated: true, completion: nil)
                                            }
                                            navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                        } else {
                                            let modal = ModalChooseOptionView(title: "Error",
                                                                              description: "You're not logged in. In order to continue with this proccess, you have to first login.", topButtonText: "Login", bottomButtonText: "Close") {
                                                navigation.dismissModal(animated: true, completion: nil)
                                                mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                                            } onBottomButtonTapped: {
                                                navigation.dismissModal(animated: true, completion: nil)
                                            }
                                            navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                        }
                                    }.padding(.horizontal, 16)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 12) {
                                            ForEach(weatherArray, id: \.id) { weather in
                                                WeatherCardView(prediction: weather.prediction, date: weather.date) {
                                                    if let user = viewModel.user {
                                                        let modal = ModalChooseOptionView(title: "Change wedding date",
                                                                                          description: "Are you sure you want to select this date? This action will change your wedding date.",
                                                                                          topButtonText: "Continue",
                                                                                          bottomButtonText: "Back") {
                                                            viewModel.startWedding(date: weather.date)
                                                        } onBottomButtonTapped: {
                                                            navigation.dismissModal(animated: true, completion: nil)
                                                        }
                                                        navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                                    } else {
                                                        let modal = ModalChooseOptionView(title: "Error",
                                                                                          description: "You're not logged in. In order to continue with this proccess, you have to first login.", topButtonText: "Login", bottomButtonText: "Close") {
                                                            navigation.dismissModal(animated: true, completion: nil)
                                                            mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                                                        } onBottomButtonTapped: {
                                                            navigation.dismissModal(animated: true, completion: nil)
                                                        }
                                                        navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                                    }
                                                }.frame(width: (UIScreen.main.bounds.size.width - 32) / 2.35 )
                                            }
                                        }
                                    }.padding(.horizontal, 16)
                                }
                            } else {
                                Spacer()
                                EmptyStateView(title: "An error has occured.",
                                               subtitle: "There has been an error while fetching data. Please try again later.")
                                Spacer()
                            }
                        }
                        
                    case .loading:
                        HStack {
                            Spacer()
                            LoaderView(height: 40, width: 40)
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                    case .failure:
                        Spacer()
                        EmptyStateView(title: "An error has occured.",
                                       subtitle: "There has been an error while fetching data. Please try again later.")
                        Spacer()
                        
                        MainButtonView(text: "Try again") {
                            viewModel.resetAll()
                        }.padding(.horizontal, 16)
                        
                    case .value(let weatherArray):
                        if !weatherArray.isEmpty {
                            if weatherArray.count == 1 || viewModel.selectedDateType == .singleDate {
                                WeatherCardView(prediction: weatherArray[0].prediction, date: weatherArray[0].date) {
                                    if let user = viewModel.user {
                                        let modal = ModalChooseOptionView(title: "Change wedding date",
                                                                          description: "Are you sure you want to select this date? This action will change your wedding date.",
                                                                          topButtonText: "Continue",
                                                                          bottomButtonText: "Back") {
                                            viewModel.startWedding(date: weatherArray[0].date)
                                        } onBottomButtonTapped: {
                                            navigation.dismissModal(animated: true, completion: nil)
                                        }
                                        navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                    } else {
                                        let modal = ModalChooseOptionView(title: "Error",
                                                                          description: "You're not logged in. In order to continue with this proccess, you have to first login.", topButtonText: "Login", bottomButtonText: "Close") {
                                            navigation.dismissModal(animated: true, completion: nil)
                                            mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                                        } onBottomButtonTapped: {
                                            navigation.dismissModal(animated: true, completion: nil)
                                        }
                                        navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                    }
                                }.padding(.horizontal, 16)
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(weatherArray, id: \.id) { weather in
                                            WeatherCardView(prediction: weather.prediction, date: weather.date) {
                                                if let user = viewModel.user {
                                                    let modal = ModalChooseOptionView(title: "Change wedding date",
                                                                                      description: "Are you sure you want to select this date? This action will change your wedding date.",
                                                                                      topButtonText: "Continue",
                                                                                      bottomButtonText: "Back") {
                                                        viewModel.startWedding(date: weather.date)
                                                    } onBottomButtonTapped: {
                                                        navigation.dismissModal(animated: true, completion: nil)
                                                    }
                                                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                                } else {
                                                    let modal = ModalChooseOptionView(title: "Error",
                                                                                      description: "You're not logged in. In order to continue with this proccess, you have to first login.", topButtonText: "Login", bottomButtonText: "Close") {
                                                        navigation.dismissModal(animated: true, completion: nil)
                                                        mainNavigation?.push(LoginScreen().asDestination(), animated: true)
                                                    } onBottomButtonTapped: {
                                                        navigation.dismissModal(animated: true, completion: nil)
                                                    }
                                                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                                                }
                                            }.frame(width: (UIScreen.main.bounds.size.width - 32) / 2.35 )
                                        }
                                    }.padding(.horizontal, 16)
                                }
                            }
                        } else {
                            Spacer()
                            EmptyStateView(title: "An error has occured.",
                                           subtitle: "There has been an error while fetching data. Please try again later.")
                            Spacer()
                        }
                        
                        MainButtonView(text: "Restart") {
                            viewModel.resetAll()
                        }.padding(.horizontal, 16)
                    }
                    
                    HomeCardView(card: viewModel.weddingCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .wedding
                    }
                    
                    HomeCardView(card: viewModel.tablesCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .guests
                    }
                    
                    HomeCardView(card: viewModel.mediaCard) {
                        TabBarCoordinator.instance.tabBarNavigation = .media
                    }
                }.padding(.vertical, 20)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .showRatingModal:
                    TabBarCoordinator.instance.tabBarNavigation = .wedding
                    viewModel.reloadWedding()
                    
                case .error:
                    let toast = Toast(text: "An error has occured. Please try again!",
                                      textColor: Color.darkRed,
                                      bg: Color.lightRed,
                                      icon: .icToastRed)
                    ToastManager.instance.show(toast)
                case .completed:
                    navigation.dismissModal(animated: true, completion: nil)
                    TabBarCoordinator.instance.tabBarNavigation = .wedding
                    viewModel.reloadWedding()
                    let toast = Toast(text: "Date added successful!")
                    ToastManager.instance.show(toast)
                }
            }
    }
}

fileprivate struct HomeCardView: View {
    let card: HomeCard
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(card.title)
                .font(.quicksandSemiBold(size: 18))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
                .padding([.top, .horizontal], 16)
            
            Text(card.description)
                .font(.quicksandRegular(size: 14))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom) {
                Image(card.image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 126)
                
                HStack {
                    InvisibleButtonView(text: card.buttonText) {
                        action()
                    }.opacity(0)
                    Spacer()
                    InvisibleButtonView(text: card.buttonText) {
                        action()
                    }
                }.padding([.horizontal, .bottom], 16)
            }
        }
        .background(Color.greenSecondary.opacity(0.5))
        .cornerRadius(8, corners: .allCorners)
        .padding(.horizontal, 16)
    }
}

fileprivate struct PeriodOfTimeFilterButtonView: View {
    let text: String
    let dateType: TypeOfDate
    let selectedDateType: TypeOfDate
    let onButtonTappedHandler: () -> ()
    
    var body: some View {
        Button {
            onButtonTappedHandler()
        } label: {
            Text(text)
                .font(.quicksandMedium(size: 16))
                .foregroundStyle(Color.mainBlack)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.nudePrimary.opacity(0.5))
                .cornerRadius(8, corners: .allCorners)
                .border(dateType == selectedDateType ? Color.greenPrimary : Color.clear,
                        width: 2,
                        cornerRadius: 8)
        }
    }
}

fileprivate struct WeatherCardView: View {
    let prediction: Prediction
    let date: String
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            Text(date.formatDate(date))
                .font(.quicksandSemiBold(size: 14))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            Text("\(String(format: "%.1f", prediction.minTemperature))°C - \(String(format: "%.1f", prediction.maxTemperature))°C")
                .font(.quicksandRegular(size: 18))
                .foregroundStyle(Color.mainBlack)
                .padding(.bottom, 4)
            
            HStack(spacing: 4) {
                Text("\(prediction.precipitationProbability)%")
                    .font(.quicksandLight(size: 12))
                    .foregroundStyle(Color.mainBlack)
                    .multilineTextAlignment(.center)
                    
                Image(.icRain)
                    .resizable()
                    .frame(width: 6, height: 10)
                    .foregroundStyle(Color.mainBlack)
            }.padding(.bottom, 12)
            
            Image(systemName: weatherIcon(for: prediction.condition))
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.mainBlack)
                .padding(.bottom, 12)
            
            SecondaryButtonView(text: "Select") {
                action()
            }.padding(.top, 8)
        }.padding(.all, 12)
            .background(Color.nudePrimary.opacity(0.5))
            .cornerRadius(8, corners: .allCorners)
    }
    
    func weatherIcon(for condition: String) -> String {
        switch condition {
        case "Sunny":
            return "sun.max.fill"
            
        case "Partly Cloudy":
            return "cloud.sun.fill"
            
        case "Rainy":
            return "cloud.rain.fill"
            
        case "Snowy":
            return "cloud.snow.fill"
            
        default: 
            return "questionmark.circle"
        }
    }
}
