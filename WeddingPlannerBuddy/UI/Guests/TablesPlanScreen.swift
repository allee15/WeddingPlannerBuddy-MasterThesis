//
//  TablesPlanScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import SwiftUI

struct TablesPlanScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject private var viewModel = TablesPlanViewModel()
    @State var showBottomSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            FullNavBarView(title: "Tables plan") {
                navigation.pop(animated: true)
            } rightButtonAction: {
                viewModel.addRectangle()
            }
            
            TablePlanView(tables: $viewModel.tables) { table in
                let modal = ModalChooseOptionView(title: "Table's participants",
                                                  description: viewModel.getTableNames(table: table),
                                                  topButtonText: "Add participant",
                                                  bottomButtonText: "Close") {
                    showBottomSheet = true
                } onBottomButtonTapped: {
                    navigation.dismissModal(animated: true, completion: nil)
                }
                navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
            }.sheet(isPresented: $showBottomSheet) {
                AddParticipantScreen(showBottomSheet: $showBottomSheet)
            }
            
            MainButtonView(text: "Add new table") {
                viewModel.addTable()
            }.padding(.horizontal, 16)
                .padding(.bottom, 24)
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
    }
}

struct TablePlanView: View {
    @Binding var tables: [Table]
    let action: (Table) -> ()
    
    var body: some View {
        ZStack {
            Color.mainWhite
            ForEach(tables) { table in
                DraggableTable(table: table, onUpdate: { updatedTable in
                    if let index = tables.firstIndex(where: { $0.id == updatedTable.id }) {
                        tables[index] = updatedTable
                    }
                }, action: {
                    action(table)
                })
            }
        }
    }
}

struct DraggableTable: View {
    @State var table: Table
    let onUpdate: (Table) -> ()
    let action: () -> ()
    
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            if table.isObject {
                Rectangle()
                    .fill(Color.mainPink)
                    .frame(width: 52, height: 38)
            } else {
                Circle()
                    .fill(Color.mainPink)
                    .frame(width: 52, height: 52)
            }
            
            Button {
                if !table.isObject {
                    action()
                }
            } label: {
                Text(table.label)
                    .font(.poppinsRegular(size: 14))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
            }
        }
        .position(x: table.position.x * UIScreen.main.bounds.width, y: table.position.y * UIScreen.main.bounds.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation
                }
                .onEnded { value in
                    dragOffset = .zero
                    let newPosition = CGPoint(
                        x: table.position.x + value.translation.width / UIScreen.main.bounds.width,
                        y: table.position.y + value.translation.height / UIScreen.main.bounds.height
                    )
                    table.position = CGPoint(
                        x: min(max(0, newPosition.x), 1),
                        y: min(max(0, newPosition.y), 1)
                    )
                    onUpdate(table)
                }
        )
        .offset(dragOffset)
    }
}
