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
    var dayId: Int64?
    
    @Published var todos: [Todo] = []
    @Published var searchText: String = ""
    @Published var showAddTodoPopup: Bool = false
    @Published var showErrorPopup: Bool = false
    
    func setup(dayId: Int64) {
        self.dayId = dayId
        todos = TodoDataStore.shared.getTodosForDayById(dayId: dayId)
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
        guard let dayId = dayId else { return }
        
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
