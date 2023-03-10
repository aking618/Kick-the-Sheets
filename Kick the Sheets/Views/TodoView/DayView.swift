//
//  TaskView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import PopupView
import SwiftUI

struct DayView: View {
    let dayId: Int64
    
    @StateObject private var viewModel = DayViewModel()
    
    var body: some View {
        BaseView {
            VStack(alignment: .center, spacing: 15){
                // header
                Text("Day \(Date().calendarDay)")
                    .ktcFont(.title)
                    .foregroundColor(KTSColors.textColor.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // subheader
                Text("🔥 \(Todo.completedCount(from: viewModel.todos)) / \(viewModel.todos.count) completed!")
                    .ktcFont(.button)
                    .foregroundColor(KTSColors.textColor.color)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(KTSColors.textColor.color)
                        .padding([.leading, .top, .bottom], 8)
                    TextField("", text: $viewModel.searchText)
                        .ktcFont(.body)
                        .foregroundColor(KTSColors.textColor.color)
                        .placeholder("Search...", when: viewModel.searchText.isEmpty)
                        .padding([.trailing, .top, .bottom], 8)
                }
                .padding([.leading, .trailing])
                .background(KTSColors.gray.color)
                .cornerRadius(10)
                
                
                // todo list
                List(Array(viewModel.todos.indices), id: \.hashValue) { index in
                    TodoRow(todo: $viewModel.todos[index])
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewModel.deleteSwipeAction(index: index)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(KTSColors.red.color)
                            
                            Button {
                                viewModel.editSwipeAction(index: index)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(KTSColors.saffron.color)
                            
                            Button {
                                viewModel.updateSwipeAction(index: index)
                            } label: {
                                Label("Complete", systemImage: "checkmark")
                            }
                            .tint(KTSColors.persianGreen.color)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .animation(.spring(), value: viewModel.todos)
                .modifier(
                    EmptyDataModifier(
                        items: viewModel.todos,
                        placeholder: Text("No todos found")
                            .padding()
                            .foregroundColor(KTSColors.textColor.color)
                            .ktcFont(.title3)
                    )
                )
                
                Spacer()
                
                RoundedButton("Add todo", action: handleButtonTap)
            }
            .padding(.top)
        }
        .popup(isPresented: $viewModel.showPopup) {
            AddTodoSheetView(
                // TODO: pass in view model instead
                dayId: viewModel.dayId ?? 0,
                todos: $viewModel.todos,
                showPopup: $viewModel.showPopup
            )
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        }
        .onAppear{
            viewModel.setup(dayId: dayId)
        }
    }
}

extension DayView {
    private func handleButtonTap() {
        viewModel.togglePopup()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayId: 1)
    }
}
