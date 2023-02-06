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
        Text("• \(todo.description)")
            .font(.title3)
            .foregroundColor(KTSColors.textColor.color)
            .background(KTSColors.purple.color)
            .listRowBackground(KTSColors.purple.color)
            .listRowSeparatorTint(KTSColors.textColor.color)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayId: 1, todos: Todo.demoList)
    }
}
