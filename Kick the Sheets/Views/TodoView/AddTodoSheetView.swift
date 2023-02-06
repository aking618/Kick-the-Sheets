//
//  AddTodoSheetView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/6/23.
//

import SwiftUI

struct AddTodoSheetView: View {
    
    let topPadding: CGFloat = 100
    let fixedHeight: Bool = false
    let bgColor: Color = .white
    
    var dayId: Int64
    @Binding var todos: [Todo]
    @Binding var showPopup: Bool
    
    @State var textFieldText: String = ""

    var body: some View {
        ZStack {
            bgColor.cornerRadius(40, corners: [.topLeft, .topRight])
            VStack {
                Color.black
                    .opacity(0.2)
                    .frame(width: 30, height: 6)
                    .clipShape(Capsule())
                    .padding(.top, 15)
                    .padding(.bottom, 10)

                ScrollView {
                    VStack {
                        Text("Add Todo")
                        
                        HStack {
                            Image(systemName: "checklist")
                                .foregroundColor(KTSColors.purple.color)
                                .padding([.leading, .top, .bottom], 8)
                            TextField("", text: $textFieldText)
                                .foregroundColor(.black)
                                .placeholder("Todo description...", when: textFieldText.isEmpty)
                                .padding([.trailing, .top, .bottom], 8)
                        }
                        .padding([.leading, .trailing])
                        
                        Button(role: .destructive) {
                            // add todo to db
                            if let todoId = TodoDataStore.shared.insertTodoForDayById(description: textFieldText, for: dayId) {
                                let todo = Todo(id: todoId, dayId: dayId, description: textFieldText, status: false)
                                todos.append(todo)
                                showPopup.toggle()
                            }
                        } label: {
                            Text("Submit")
                        }
                    }
                }
                    .padding(.bottom, 30)
                    .applyIf(fixedHeight) {
                        $0.frame(height: UIScreen.main.bounds.height - topPadding)
                    }
                    .applyIf(!fixedHeight) {
                        $0.frame(maxHeight: UIScreen.main.bounds.height - topPadding)
                    }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct AddTodoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheetView(dayId: 0, todos: .constant([]), showPopup: .constant(false))
    }
}
