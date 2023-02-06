//
//  TodoRow.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/30/23.
//

import SwiftUI

struct TodoRow: View {
    
    @Binding var todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.description)
                .font(.title3)
                .foregroundColor(KTSColors.textColor.color)
                .background(KTSColors.darkPurple.color)
                .strikethrough(todo.status)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(KTSColors.darkPurple.color)
        .listRowBackground(KTSColors.lightPurple.color)
        .cornerRadius(12)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayId: 1, todos: Todo.demoList)
    }
}
