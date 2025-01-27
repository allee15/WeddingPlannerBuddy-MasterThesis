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
                    HStack {
                        Text("Select a day or a period of time in order to get recommendations for weather.")
                            .foregroundStyle(Color.mainBlack)
                            .font(.poppinsRegular(size: 16))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 8) {
                        PeriodOfTimeFilterButtonView(text: "One day",
                                                    dateType: .singleDate,
                                                    selectedDateType: viewModel.selectedDateType) {
                            if viewModel.selectedDateType != .singleDate {
                                viewModel.selectedDateType = .singleDate
                            } else {
                                viewModel.selectedDateType = .anytime
                            }
                        }
                        
                        PeriodOfTimeFilterButtonView(text: "Period of time",
                                                    dateType: .periodOfTime,
                                                    selectedDateType: viewModel.selectedDateType) {
                            if viewModel.selectedDateType != .periodOfTime {
                                viewModel.selectedDateType = .periodOfTime
                            } else {
                                viewModel.selectedDateType = .anytime
                            }
                        }
                        
                        Spacer()
                    }
                    
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
                        }
                        
                        MainButtonView(text: "Get recommendations") {
                            viewModel.getRecommendations()
                        }
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
                        
                        MainButtonView(text: "Get recommendations") {
                            viewModel.getRecommendations()
                        }
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
                    .padding(.horizontal, 16)
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
                    Text(date.description)//.medicalFileDateToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                } else if let singleDateSelected {
                    Text(date.description)//.medicalFileDateToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                } else if let selectedEndDate {
                    Text(date.description)//.medicalFileDateToString())
                        .font(.poppinsBold(size: 14))
                        .foregroundStyle(Color.mainPink)
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeScreen()
}
