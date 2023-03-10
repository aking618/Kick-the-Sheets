//
//  DayViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/7/23.
//

import SwiftUI

protocol SwipeActionHandler {
    func deleteSwipeAction(index: Int)
    func editSwipeAction(index: Int)
    func updateSwipeAction(index: Int)
}

class DayViewModel: ObservableObject {
    var dayId: Int64?
    
    @Published var todos: [Todo] = []
    @Published var searchText: String = ""
    @Published var showPopup: Bool = false
    
    func setup(dayId: Int64) {
        self.dayId = dayId
        todos = TodoDataStore.shared.getTodosForDayById(dayId: dayId)
    }
    
    func togglePopup() {
        showPopup.toggle()
    }
}

// MARK: - Swipe Action Handlers
extension DayViewModel: SwipeActionHandler {
    func deleteSwipeAction(index: Int) {
        print("Deleting todo")
        if TodoDataStore.shared.deleteTodo(entry: todos[index]) {
            print("Deleted todo")
            todos.remove(at: index)
        } else {
            print("Unable to delete todo")
        }
    }
    
    func editSwipeAction(index: Int) {
        print("Editing todo")
    }
    
    func updateSwipeAction(index: Int) {
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
