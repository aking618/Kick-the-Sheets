//
//  AddTodoSheetView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/6/23.
//

import SwiftUI

struct AddTodoSheetView: View {
    @EnvironmentObject var appState: AppState

    let topPadding: CGFloat = 100
    let bgColor: Color = KTSColors.background.color

    var dayId: Int64
    @Binding var todos: [Todo]
    @Binding var showPopup: Bool
    @Binding var errorPopup: Bool

    @State var textFieldText: String = ""
    @FocusState var focusField: Bool

    @ViewBuilder
    private var background: some View {
        bgColor.cornerRadius(40)
    }

    @ViewBuilder
    private var swipeIndicator: some View {
        Color.black
            .opacity(0.2)
            .frame(width: 30, height: 6)
            .clipShape(Capsule())
            .padding(.top, 15)
            .padding(.bottom, 10)
    }

    @ViewBuilder
    private var formWrapper: some View {
        VStack {
            swipeIndicator
            Spacer()
            todoForm
                .padding(.bottom, 40)
            Spacer()
        }
    }

    @ViewBuilder
    private var todoForm: some View {
        VStack {
            Text("Add Todo")
                .ktsFont(.button)
            todoTextField
            addTodoButton
            cancelButton
        }
        .padding([.leading, .trailing])
    }

    @ViewBuilder
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
        }
        .padding([.leading, .trailing])
        .background(KTSColors.rowBackground.color)
        .cornerRadius(10)
        .shadow(radius: 1)
    }

    @ViewBuilder
    private var addTodoButton: some View {
        RoundedButton("Submit", backgroundColor: .persianGreen) {
            // TODO: move action to view model
            guard !textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                errorPopup.toggle()
                return
            }
            if let todoId = appState.todoService.insertTodo(description: textFieldText, for: appState.currentDayId) {
                let todo = Todo(id: todoId, dayId: appState.currentDayId, description: textFieldText, status: false)
                todos.append(todo)
                showPopup.toggle()
            }
        }
    }

    @ViewBuilder
    private var cancelButton: some View {
        RoundedButton("Cancel", backgroundColor: .burntSienna) { showPopup.toggle() }
    }

    var body: some View {
        ZStack {
            background
            formWrapper
        }
        .onAppear {
            focusField = true
        }
    }
}

struct AddTodoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheetView(dayId: 0, todos: .constant([]), showPopup: .constant(false), errorPopup: .constant(false))
    }
}
