//
//  TablesPlanScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 10.12.2024.
//

import SwiftUI

struct TablesPlanScreen: View {
    @EnvironmentObject private var navigation: Navigation
    @StateObject var viewModel: TablesPlanViewModel
    @State var tableId: String = ""
    @State private var shouldReloadWeddingDetails = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavBarMultipleRightButtonsView(title: "Tables plan") {
                viewModel.reloadUser()
                navigation.pop(animated: true)
            } firstRightButtonAction: {
                viewModel.addRectangle()
            } secondRightButtonAction: {
                viewModel.addTable()
            }
            
            ZoomableScrollView {
                TablePlanView(tables: $viewModel.tables) { table in
                    let modal = ModalChooseOptionView(title: "Table's participants",
                                                      description: viewModel.getTableNames(table: table),
                                                      topButtonText: "Add participant",
                                                      bottomButtonText: "Close") {
                        tableId = table.id
                        navigation.dismissModal(animated: true, completion: nil)
                        let vm = AddParticipantViewModel(userId: viewModel.userId, tableId: tableId)
                        let screen = AddParticipantScreen(viewModel: vm, onComplete: {
                            shouldReloadWeddingDetails = true
                        })
                        navigation.push(screen.asDestination(), animated: true)
                    } onBottomButtonTapped: {
                        navigation.dismissModal(animated: true, completion: nil)
                    }
                    navigation.presentPopup(modal.asDestination(), animated: true, completion: nil)
                } onTableMoved: { movedTable in
                    viewModel.updateTablePosition(movedTable)
                }
            }
        }.background(Color.mainWhite)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .horizontal])
            .onChange(of: shouldReloadWeddingDetails) { _, newValue in
                if newValue {
                    viewModel.reloadUser()
                    shouldReloadWeddingDetails = false
                }
            }
            .onReceive(viewModel.eventSubject) { event in
                switch event {
                case .tableAdded:
                    let toast = Toast(text: "Table added successful!")
                    ToastManager.instance.show(toast)
                    
                case .rectangleAdded:
                    let toast = Toast(text: "Object added successful!")
                    ToastManager.instance.show(toast)
                    
                case .failed:
                    let toast = Toast(text: "An error has occured. Please try again!",
                                      textColor: Color.darkRed,
                                      bg: Color.lightRed,
                                      icon: .icToastRed)
                    ToastManager.instance.show(toast)
                }
            }
    }
}

struct TablePlanView: View {
    @Binding var tables: [Table]
    let action: (Table) -> ()
    let onTableMoved: (Table) -> ()
    
    var body: some View {
        ZStack {
            Color.mainWhite
            ForEach(tables) { table in
                DraggableTable(table: table, onUpdate: { updatedTable in
                    if let index = tables.firstIndex(where: { $0.id == updatedTable.id }) {
                        tables[index] = updatedTable
                        onTableMoved(updatedTable)
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
                    .fill(Color.greenSecondary)
                    .frame(width: 80, height: 35)
                    
            } else {
                Circle()
                    .fill(Color.nudeSecondary)
                    .frame(width: 56, height: 56)
            }
            
            Button {
                if !table.isObject {
                    action()
                }
            } label: {
                Text(table.label)
                    .font(.quicksandMedium(size: 16))
                    .foregroundColor(Color.mainWhite)
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
