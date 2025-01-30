//
//  HomeScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = HomeViewModel()
    
    @State var showDatePicker: Bool = false
    @State var showStartDate: Bool = true
    @State var showEndDate: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            LeftNavBarView(title: "Home", hasBackButton: false) { }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    switch viewModel.weatherState {
                    case .notStarted:
                        HStack {
                            Text("Select a day or a period of time in order to get weather recommendations for your current location. Note that you can get recommendations for other locations when your start planning your wedding!")
                                .foregroundStyle(Color.mainBlack)
                                .font(.poppinsRegular(size: 16))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                        HStack(spacing: 8) {
                            PeriodOfTimeFilterButtonView(text: "One day",
                                                        dateType: .singleDate,
                                                        selectedDateType: viewModel.selectedDateType) {
                                viewModel.selectedDateType = .singleDate
                            }
                            
                            PeriodOfTimeFilterButtonView(text: "Period of time",
                                                        dateType: .periodOfTime,
                                                        selectedDateType: viewModel.selectedDateType) {
                                viewModel.selectedDateType = .periodOfTime
                            }
                            
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                        if viewModel.selectedDateType == .singleDate {
                            VStack(spacing: 0) {
                                DateView(
                                    placeHolder: "Select date",
                                    date: $viewModel.currentDate,
                                    singleDateSelected: viewModel.currentDate) {
                                        showDatePicker = true
                                    }.background(Color(hex: "#F7F7F8"))
                                    .cornerRadius(8, corners: [.topLeft, .topRight])
                                    .padding(.top, 16)
                                
                                DividerView()
                                
                                DatePicker("", selection: $viewModel.currentDate,
                                           in: (Date())..., displayedComponents: .date)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .accentColor(Color.mainPink)
                                    .background(Color(hex: "#F7F7F8"))
                                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                            }.padding(.horizontal, 16)
                            
                            MainButtonView(text: "Get recommendations") {
                                viewModel.getRecommendations()
                            }.padding(.horizontal, 16)
                        }
                        
                        
                        if viewModel.selectedDateType == .periodOfTime {
                            VStack(spacing: 0) {
                                DateView(
                                    placeHolder: "Start date",
                                    date: $viewModel.startDate,
                                    selectedStartDate: viewModel.startDate) {
                                        withAnimation {
                                            showStartDate = true
                                            showEndDate = false
                                        }
                                    }
                                    .background(Color(hex: "#F7F7F8"))
                                    .cornerRadius(8, corners: [.topLeft, .topRight])
                                
                                if showStartDate == true {
                                    DividerView()
                                    
                                    DatePicker("", selection: $viewModel.startDate, in: (Date())..., displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .accentColor(Color.mainPink)
                                        .background(Color(hex: "#F7F7F8"))
                                        .transition(.opacity)
                                }
                                
                                DividerView()
                                
                                DateView(
                                    placeHolder: "End date",
                                    date: $viewModel.endDate,
                                    selectedEndDate: viewModel.endDate) {
                                        withAnimation {
                                            showEndDate = true
                                            showStartDate = false
                                        }
                                    }
                                    .background(Color(hex: "#F7F7F8"))
                                    .cornerRadius(8, corners: showStartDate == true ? [.bottomLeft, .bottomRight] : [])
                                
                                if showEndDate == true {
                                    DividerView()
                                    
                                    DatePicker("", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .accentColor(Color.mainPink)
                                        .background(Color(hex: "#F7F7F8"))
                                        .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                                        .transition(.opacity)
                                }
                            }
                            .background(Color(hex: "#F7F7F8"))
                            .cornerRadius(8, corners: .allCorners)
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                            
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
                                LoaderView()
                                Spacer()
                            }.padding(.horizontal, 16)
                            
                        case .failure:
                            EmptyView()
                        case .value(let weather):
                            HStack {
                                Text("Here is a list of predictions for the next days:")
                                    .foregroundStyle(Color.mainBlack)
                                    .font(.poppinsRegular(size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }.padding(.horizontal, 16)
                            
                            if weather.predictions.count == 1 {
                                WeatherCardView(prediction: weather.predictions[0]) {
                                    //TODO open wedding tab with the date and location selected
                                }.padding(.horizontal, 16)
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(weather.predictions, id: \.id) { prediction in
                                            WeatherCardView(prediction: prediction) {
                                                //TODO open wedding tab with the date and location selected
                                            }.frame(width: (UIScreen.main.bounds.size.width - 32) / 2.35 )
                                        }
                                    }.padding(.horizontal, 16)
                                }
                            }
                        }
                        
                    case .loading:
                        HStack {
                            Spacer()
                            LoaderView()
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                    case .failure:
                        HStack {
                            Text("An error has occured, please try again.")
                                .foregroundStyle(Color.mainBlack)
                                .font(.poppinsRegular(size: 16))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                        MainButtonView(text: "Try again") {
                            viewModel.resetAll()
                        }.padding(.horizontal, 16)
                        
                    case .value(let weather):
                        HStack {
                            Text("Here is a list of predictions for the period that you've selected:")
                                .foregroundStyle(Color.mainBlack)
                                .font(.poppinsRegular(size: 16))
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }.padding(.horizontal, 16)
                        
                        if weather.predictions.count == 1 {
                            WeatherCardView(prediction: weather.predictions[0]) {
                                //TODO open wedding tab with the date and location selected
                            }.padding(.horizontal, 16)
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(weather.predictions, id: \.id) { prediction in
                                        WeatherCardView(prediction: prediction) {
                                            //TODO open wedding tab with the date and location selected
                                        }.frame(width: (UIScreen.main.bounds.size.width - 32) / 2.35 )
                                    }
                                }.padding(.horizontal, 16)
                            }
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
                }.padding(.top, 20)
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

fileprivate struct HomeCardView: View {
    let card: HomeCard
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(card.title)
                .font(.poppinsSemiBold(size: 18))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
                .underline()
            
            Text(card.description)
                .font(.poppinsRegular(size: 16))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.leading)
            
            Image(card.image)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 64)
            
            Button {
                action()
            } label: {
                HStack(spacing: 8) {
                    Text("Check it out")
                        .font(.poppinsRegular(size: 16))
                        .foregroundStyle(Color.mainBlack)
                    
                    Image(.icItemresultArrow)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color.mainBlack)
                }
            }
        }.padding(.all, 20)
            .borderWithShadow(borderColor: Color.mainBlack,
                              width: 2,
                              cornerRadius: 8,
                              fillColor: Color.clear,
                              shadowColor: Color.mainBlack.opacity(0.3),
                              shadowRadius: 8,
                              x: -3,
                              y: 0)
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
                .font(.poppinsRegular(size: 16))
                .foregroundStyle(Color.mainBlack)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.7))
                .cornerRadius(8, corners: .allCorners)
                .border(dateType == selectedDateType ? Color.mainPink : Color.gray.opacity(0.7),
                        width: 1,
                        cornerRadius: 8)
        }
    }
}

fileprivate struct DateView: View {
    let placeHolder: String
    @Binding var date: Date
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    var singleDateSelected: Date?
    let onButtonTappedHandler: () -> ()
    
    var body: some View {
        Button {
            onButtonTappedHandler()
        } label: {
            HStack(spacing: 0) {
                Text(placeHolder)
                    .font(.poppinsRegular(size: 16))
                    .foregroundStyle(Color.mainBlack)
                
                Spacer()
                
                if let selectedStartDate {
                    Text(date.dateSheetToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                } else if let singleDateSelected {
                    Text(date.dateSheetToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                } else if let selectedEndDate {
                    Text(date.dateSheetToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
    }
}

fileprivate struct WeatherCardView: View {
    let prediction: Prediction
    let action: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            Text(prediction.date.remakeWeather())
                .font(.poppinsRegular(size: 16))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Text("\(String(format: "%.1f", prediction.minTemperature))°C - \(String(format: "%.1f", prediction.maxTemperature))°C")
                .font(.poppinsSemiBold(size: 20))
                .foregroundStyle(Color.mainBlack)
                .padding(.bottom, 4)
            
            Text("Precipitation probability: \(prediction.precipitationProbability)%")
                .font(.poppinsRegular(size: 12))
                .foregroundStyle(Color.mainBlack)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            
            Image(systemName: weatherIcon(for: prediction.condition))
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .foregroundStyle(Color.mainPink)
            
            MainButtonView(text: "Select") {
                action()
            }.padding(.top, 16)
        }.padding(.all, 20)
            .background(Color.gray.opacity(0.2))
            .border(Color.gray.opacity(0.5), width: 1, cornerRadius: 8)
            .padding(.bottom, 4)
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
