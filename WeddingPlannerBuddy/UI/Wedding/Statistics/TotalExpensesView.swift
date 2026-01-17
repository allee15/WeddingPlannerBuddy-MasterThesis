//
//  TotalExpensesView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 17.01.2026.
//

import SwiftUI

struct TotalExpensesView: View {
    
    let prices: [PriceItem]
    private var totalCost: Int {
        prices.map(\.price).reduce(0, +)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 6) {
                Image(.icExpenses)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.mainBlack)
                    .frame(width: 24, height: 24)
                
                Text("\(totalCost) RON")
                    .foregroundStyle(Color.mainBlack)
                    .font(.quicksandBold(size: 18))
                
                Text("Total spent")
                    .foregroundStyle(Color.mainBlack)
                    .font(.quicksandMedium(size: 16))
            }
            
            CircluarDiagramView(prices: prices, total: totalCost)
                .padding(40)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CircluarDiagramView: View {
    
    let prices: [PriceItem]
    let total: Int
    
    var body: some View {
        ZStack {
            ForEach(Array(prices.enumerated()), id: \.offset) { index, element in
                let start = startingOffset(for: index)
                Circle()
                    .trim(from: start, to: start + percentage(for: element))
                    .stroke(element.color, lineWidth: 40)
            }
        }
        .padding(.horizontal, 20)
        .rotationEffect(.degrees(-90))
    }
    
    private func percentage(for item: PriceItem) -> CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(item.price) / CGFloat(total)
    }
    
    private func startingOffset(for index: Int) -> CGFloat {
        guard total > 0 else { return 0 }
        
        let previousItems = prices.prefix(index)
        let sum = previousItems.reduce(0) { $0 + $1.price }
        
        return CGFloat(sum) / CGFloat(total)
    }
}

struct ExpenseCardView: View {
    
    let item: PriceItem
    let total: Int
    
    private var percentage: String {
        guard total > 0 else { return "0%" }
        let value = (Double(item.price) / Double(total)) * 100
        if value < 0.1 && value > 0 {
            return "<0.1%"
        } else {
            return String(format: "%.1f%%", value)
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .stroke(item.color, lineWidth: 4)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 24)
            
            Text(item.name)
                .foregroundStyle(Color.mainBlack)
                .font(.quicksandBold(size: 16))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                
                Text("\(item.price) RON")
                    .foregroundStyle(Color.mainBlack)
                    .font(.quicksandBold(size: 16))
                
                Text(percentage)
                    .foregroundStyle(item.color)
                    .font(.quicksandBold(size: 16))
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 25)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
