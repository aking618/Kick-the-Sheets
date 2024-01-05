//
//  AddTodoSheetView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/6/23.
//

import Services
import Shared
import SwiftUI

struct AddTodoSheetView: View {
    @EnvironmentObject var appState: AppState

    let topPadding: CGFloat = 100
    let bgColor: Color = KTSColors.background.color

    @State var showInlineError: Bool = false
    @State var textFieldText: String = ""
    @FocusState var focusField: Bool

    var body: some View {
        BaseView {
            todoForm
                .padding(.bottom, 40)
        }
        .onAppear {
            focusField = true
        }
    }
}

// MARK: - Views

extension AddTodoSheetView {
    private var todoForm: some View {
        VStack(spacing: 20) {
            Text("Add Todo")
                .ktsFont(.button)
                .accessibilityIdentifier("addTodoView")

            todoTextField

            if showInlineError {
                errorText
            }

            VStack(spacing: 5) {
                addTodoButton
                cancelButton
            }
        }
        .animation(.linear, value: showInlineError)
    }

    private var todoTextField: some View {
        HStack {
            Image(systemName: "checklist")
                .foregroundColor(KTSColors.text.color)
                .padding([.leading, .top, .bottom], 8)
            TextField("", text: $textFieldText)
                .ktsFont(.body)
                .foregroundColor(KTSColors.text.color)
                .placeholder("Todo description...", when: textFieldText.isEmpty)
                .padding([.trailing, .top, .bottom], 8)
                .focused($focusField, equals: true)
                .accessibilityIdentifier("addTodoTextField")
        }
        .padding([.leading, .trailing])
        .background(KTSColors.rowBackground.color)
        .cornerRadius(10)
        .shadow(radius: 1)
    }

    private var errorText: some View {
        Text("Todos cannot be empty.")
            .ktsFont(.caption)
            .foregroundColor(KTSColors.burntSienna.color)
            .accessibilityIdentifier("addTodoError")
    }

    private var addTodoButton: some View {
        RoundedButton("Submit", backgroundColor: .persianGreen, action: handleAddTodo)
    }

    private var cancelButton: some View {
        RoundedButton("Cancel", backgroundColor: .burntSienna, action: { appState.pop() })
    }
}

// MARK: - Actions

extension AddTodoSheetView {
    private func handleAddTodo() {
        guard !textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showInlineError.toggle()
            return
        }
        if let todoId = appState.todoService.insertTodo(description: textFieldText, for: appState.currentDayId) {
            let todo = Todo(id: todoId, dayId: appState.currentDayId, description: textFieldText, status: false)
            appState.todosForToday.append(todo)
            appState.pop()
        }
    }
}

struct AddTodoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheetView()
            .environmentObject(AppState())
    }
}
