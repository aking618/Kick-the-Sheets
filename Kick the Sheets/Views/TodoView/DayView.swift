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
        viewModel = DayViewModel(id: dayId, todos: todos)
    }

    @ViewBuilder
    private var header: some View {
        Text("Day \(Date().calendarDay)")
            .ktsFont(.title)
            .foregroundColor(KTSColors.text.color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var subHeader: some View {
        Text("🔥 \(Todo.completedCount(from: viewModel.todos)) / \(viewModel.todos.count) completed!")
            .ktsFont(.button)
            .foregroundColor(KTSColors.text.color)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(KTSColors.text.color)
                .padding([.leading, .top, .bottom], 8)
            TextField("", text: $viewModel.searchText)
                .ktsFont(.body)
                .foregroundColor(KTSColors.text.color)
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
        List(viewModel.filteredTodos, id: \.hashValue) { index in
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
                items: viewModel.filteredTodos,
                placeholder: Text("No todos found")
                    .padding()
                    .foregroundColor(KTSColors.text.color)
                    .ktsFont(.title3)
            )
        )
    }

    var body: some View {
        BaseView {
            VStack(alignment: .center, spacing: 15) {
                header
                subHeader
                searchBar
                todoList
                Spacer()

                RoundedButton("Add todo", action: handleButtonTap)
            }
            .padding(.top)
        }
        .addTodoPopup(viewModel: _viewModel)
        .errorPopup($viewModel.showErrorPopup)
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
