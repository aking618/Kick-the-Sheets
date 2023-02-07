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
    @State var todos: [Todo] = []
    
    @State var searchText: String = ""
    @State var showPopup: Bool = false
    
    var body: some View {
        BaseView(color: KTSColors.lightPurple.color) {
            VStack(alignment: .center, spacing: 15){
                // header
                Text("Day \(Date().calendarDay)")
                    .font(.title.bold())
                    .foregroundColor(KTSColors.textColor.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // subheader
                Text("🔥 \(Todo.completedCount(from: todos)) / \(todos.count) completed!")
                    .font(.title3)
                    .foregroundColor(KTSColors.textColor.color)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(KTSColors.textColor.color)
                        .padding([.leading, .top, .bottom], 8)
                    TextField("", text: $searchText)
                        .foregroundColor(KTSColors.textColor.color)
                        .placeholder("Search...", when: searchText.isEmpty)
                        .padding([.trailing, .top, .bottom], 8)
                }
                .padding([.leading, .trailing])
                .background(KTSColors.darkPurple.color)
                .cornerRadius(10)
                
                
                // todo list
                List(Array(todos.indices), id: \.hashValue) { index in
                        TodoRow(todo: $todos[index])
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                print("Deleting todo")
                                if TodoDataStore.shared.deleteTodo(entry: todos[index]) {
                                    print("Deleted todo")
                                    todos.remove(at: index)
                                } else {
                                    print("Unable to delete todo")
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            
                            Button {
                                print("Editing todo")
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                            
                            Button {
                                print("Completing todo")
                                todos[index].status.toggle()
                                if TodoDataStore.shared.updateTodo(entry: todos[index]) {
                                    print("Updated todo")
                                } else {
                                    print("Unable to update todo")
                                }
                                
                                _ = TodoDataStore.shared.updateDayCompletion(for: dayId, with: Day.isDayComplete(todos))
                                
                            } label: {
                                Label("Complete", systemImage: "checkmark")
                            }
                            .tint(.green)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .animation(.spring(), value: todos)
                .modifier(EmptyDataModifier(
                    items: todos,
                    placeholder: Text("No todos found")
                        .padding()
                        .foregroundColor(KTSColors.textColor.color)
                        .font(.title3))
                )
                
                Spacer()
                
                RoundedButton("Add todo", action: handleButtonTap)
            }
            .padding(.top)
        }
        .popup(isPresented: $showPopup) {
            AddTodoSheetView(dayId: dayId, todos: $todos, showPopup: $showPopup)
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        }
        .onAppear(perform: handleOnAppear)
    }
}

extension DayView {
    private func handleOnAppear() {
        todos = TodoDataStore.shared.getTodosForDayById(dayId: dayId)
    }
    
    private func handleButtonTap() {
        showPopup = true
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayId: 1, todos: Todo.demoList)
    }
}
