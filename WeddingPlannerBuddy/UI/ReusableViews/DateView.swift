//
//  DateView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 04.04.2025.
//

import SwiftUI

struct DateView: View {
    let placeHolder: String
    @Binding var date: Date
    var selectedStartDate: Date?
    var selectedEndDate: Date?
    var singleDateSelected: Date?
    var showHour: Bool = false
    let onButtonTappedHandler: () -> ()
    
    var body: some View {
        Button {
            onButtonTappedHandler()
        } label: {
            HStack(spacing: 0) {
                Text(placeHolder)
                    .font(.quicksandMedium(size: 16))
                    .foregroundStyle(Color.mainBlack)
                
                Spacer()
                
                if selectedStartDate != nil {
                    Text(date.formatted(dateFormat: .ddMMMYYYY_space))
                        .font(.quicksandBold(size: 14))
                        .foregroundStyle(Color.greenSecondary)
                } else if singleDateSelected != nil {
                    Text(!showHour ? date.formatted(dateFormat: .ddMMMYYYY_space) : date.formatted(dateFormat: .HHmm))
                        .font(.quicksandBold(size: 14))
                        .foregroundStyle(Color.greenSecondary)
                } else if selectedEndDate != nil {
                    Text(date.formatted(dateFormat: .ddMMMYYYY_space))
                        .font(.quicksandBold(size: 14))
                        .foregroundStyle(Color.greenSecondary)
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
        }
    }
}
