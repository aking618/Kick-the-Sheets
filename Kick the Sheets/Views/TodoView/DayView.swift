//
//  TaskView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import PopupView
import SwiftUI

struct DayView: View {
    @EnvironmentObject var appState: AppState

    @State var searchText: String = ""

    var body: some View {
        BaseView {
            VStack(alignment: .center, spacing: 15) {
                header
                subHeader
                searchBar
                todoList
                Spacer()

                NavigationLink(value: DayTabDestination.addForm) {
                    RoundedButton("Add todo", action: { appState.navigate(to: DayTabDestination.addForm) })
                }
            }
            .padding(.top)
        }
        .navigationDestination(for: DayTabDestination.self) { dest in
            switch dest {
            case .addForm:
                AddTodoSheetView().environmentObject(appState)
            }
        }
    }
}

// MARK: - Views

extension DayView {
    private var header: some View {
        Text("Day \(Date().calendarDay)")
            .ktsFont(.title)
            .foregroundColor(KTSColors.text.color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var subHeader: some View {
        Text("🔥 \(Todo.completedCount(from: appState.todosForToday)) / \(appState.todosForToday.count) completed!")
            .ktsFont(.button)
            .foregroundColor(KTSColors.text.color)
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(KTSColors.text.color)
                .padding([.leading, .top, .bottom], 8)
            TextField("", text: $searchText)
                .ktsFont(.body)
                .foregroundColor(KTSColors.text.color)
                .placeholder("Search...", when: searchText.isEmpty)
                .padding([.trailing, .top, .bottom], 8)
        }
        .padding([.leading, .trailing])
        .background(KTSColors.rowBackground.color)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(KTSColors.border.color, lineWidth: 1)
        )
        .shadow(radius: 1)
    }

    private var todoList: some View {
        List(filteredTodos, id: \.hashValue) { index in
            TodoRow(todo: $appState.todosForToday[index],
                    doneAction: { updateAction(index: index) },
                    deleteAction: { deleteAction(index: index) })
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .animation(.spring(), value: appState.todosForToday)
        .modifier(
            EmptyDataModifier(
                items: filteredTodos,
                placeholder: Text("No todos found")
                    .padding()
                    .foregroundColor(KTSColors.text.color)
                    .ktsFont(.title3)
            )
        )
    }
}

// MARK: - Computed Properties

extension DayView {
    var filteredTodos: [Int] {
        return searchText.isEmpty ? appState.todosForToday.enumerated().map { i, _ in i } : appState.todosForToday.enumerated().compactMap { index, todo in
            todo.description.caseInsensitiveContains(searchText) ? index : nil
        }
    }
}

// MARK: - Actions

extension DayView {
    func deleteAction(index: Int) {
        print("Deleting todo")
        if appState.todoService.deleteTodo(entry: appState.todosForToday[index]) {
            print("Deleted todo")
            appState.todosForToday.remove(at: index)
        } else {
            print("Unable to delete todo")
        }
    }

    func updateAction(index: Int) {
        print("Completing todo")
        appState.todosForToday[index].status.toggle()
        if appState.todoService.updateTodo(entry: appState.todosForToday[index]) {
            print("Updated todo")
        } else {
            print("Unable to update todo")
        }

        _ = appState.todoService.updateDayCompletion(for: appState.currentDayId, with: Day.isDayComplete(appState.todosForToday))
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
