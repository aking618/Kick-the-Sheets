//
//  TaskView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import PopupView
import SwiftUI

struct DayView: View {
    @ObservedObject private var viewModel: DayViewModel
    
    init(dayId: Int64, todos: Binding<[Todo]>) {
        self.viewModel = DayViewModel(id: dayId, todos: todos)
    }
    
    @ViewBuilder
    private var header: some View {
        Text("Day \(Date().calendarDay)")
            .ktcFont(.title)
            .foregroundColor(KTSColors.textColor.color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var subHeader: some View {
        Text("🔥 \(Todo.completedCount(from: viewModel.todos)) / \(viewModel.todos.count) completed!")
            .ktcFont(.button)
            .foregroundColor(KTSColors.textColor.color)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var searchBar: some View {
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
        .background(KTSColors.rowBackground.color)
        .cornerRadius(10)
        .shadow(radius: 1)
    }
    
    @ViewBuilder
    private var todoList: some View {
        List(Array(viewModel.todos.indices), id: \.hashValue) { index in
            TodoRow(todo: $viewModel.todos[index],
                    doneAction: { viewModel.updateAction(index: index) },
                    deleteAction: { viewModel.deleteAction(index: index) })
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
    }
    
    @ViewBuilder
    private var popup: some View {
        AddTodoSheetView(
            // TODO: pass in view model instead
            dayId: viewModel.dayId ?? 0,
            todos: $viewModel.todos,
            showPopup: $viewModel.showAddTodoPopup,
            errorPopup: $viewModel.showErrorPopup
        )
    }
    
    @ViewBuilder
    private var errorPopup: some View {
        Text("New todos cannot be blank")
            .ktcFont(.body)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 60, leading: 32, bottom: 16, trailing: 32))
            .frame(maxWidth: .infinity)
            .background(Color(hex: "FE504E"))
    }
    
    var body: some View {
        BaseView {
            VStack(alignment: .center, spacing: 15){
                header
                subHeader
                searchBar
                todoList
                Spacer()
                
                RoundedButton("Add todo", action: handleButtonTap)
            }
            .padding(.top)
        }
        .popup(isPresented: $viewModel.showAddTodoPopup) {
            popup
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .animation(.spring())
                .backgroundColor(.black.opacity(0.4))
                .isOpaque(true)
            
            // TODO: try using a tost in the middle of the screen instead of a bottom sheet
            // TODO: test with a keyboard and look at layout changes
            
        }
        .popup(isPresented: $viewModel.showErrorPopup) {
            errorPopup
        } customize: {
            $0
                .type(.toast)
                .position(.top)
                .animation(.easeInOut)
                .closeOnTapOutside(true)
                .autohideIn(3)
        }
    }
}

extension DayView {
    private func handleButtonTap() {
        viewModel.toggleTodoPopup()
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayId: 1, todos: .constant(.init()))
    }
}
