//
//  FoodTypeView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 05.04.2025.
//

import SwiftUI

struct FoodTypeView: View {
   let title: String
   let food: [String]
   
   var body: some View {
       if !food.isEmpty {
           VStack(alignment: .leading, spacing: 8) {
               Text(title)
                   .foregroundStyle(Color.mainBlack)
                   .font(.quicksandMedium(size: 16))
                   .fixedSize()
                   .padding(.vertical, 8)
                   .padding(.horizontal, 12)
                   .background(Color.mainWhite.opacity(0.5))
                   .cornerRadius(4, corners: .allCorners)
               
               ForEach(food, id: \.self) { item in
                   HStack(spacing: 4) {
                       Image(.icBullet)
                           .resizable()
                           .renderingMode(.template)
                           .foregroundStyle(Color.mainBlack)
                           .frame(width: 16, height: 16)
                       
                       Text(item)
                           .foregroundStyle(Color.mainBlack)
                           .font(.quicksandMedium(size: 16))
                       
                       Spacer()
                   }
               }
           }.padding(.all, 12)
               .background(Color.nudePrimary.opacity(0.4))
               .cornerRadius(4, corners: .allCorners)
       }
   }
}

