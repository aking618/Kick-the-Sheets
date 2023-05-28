//
//  DayViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

protocol TodoRowActionHandler {
    func deleteAction(index: Int)
    func updateAction(index: Int)
}

class DayViewModel: ObservableObject {
    @Published var dayId: Int64

    @Binding var todos: [Todo]

    @Published var searchText: String = ""
    @Published var showAddTodoPopup: Bool = false
    @Published var showErrorPopup: Bool = false

    var filteredTodos: [Int] {
        return searchText.isEmpty ? todos.enumerated().map { i, _ in i } : todos.enumerated().compactMap { index, todo in
            todo.description.caseInsensitiveContains(searchText) ? index : nil
        }
    }

    init(id: Int64, todos: Binding<[Todo]> = .constant([])) {
        dayId = id
        _todos = todos
    }

    func toggleTodoPopup() {
        showAddTodoPopup.toggle()
    }

    func toggleErrorPopup() {
        showErrorPopup.toggle()
    }
}

// MARK: - Swipe Action Handlers

extension DayViewModel: TodoRowActionHandler {
    func deleteAction(index: Int) {
        print("Deleting todo")
        if TodoDataStore.shared.deleteTodo(entry: todos[index]) {
            print("Deleted todo")
            todos.remove(at: index)
        } else {
            print("Unable to delete todo")
        }
    }

    func updateAction(index: Int) {
        print("Completing todo")
        todos[index].status.toggle()
        if TodoDataStore.shared.updateTodo(entry: todos[index]) {
            print("Updated todo")
        } else {
            print("Unable to update todo")
        }

        _ = TodoDataStore.shared.updateDayCompletion(for: dayId, with: Day.isDayComplete(todos))
    }
}
