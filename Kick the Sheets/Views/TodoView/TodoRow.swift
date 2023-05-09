//
//  TodoRow.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/30/23.
//

import SwiftUI

struct TodoRow: View {
    
    @Binding var todo: Todo
    
    var doneAction: () -> Void
    var deleteAction: () -> Void
    
    var body: some View {
        HStack {
            CircleCheckmarkView(isChecked: $todo.status)
                .onTapGesture {
                    doneAction()
                }
            Text(todo.description)
                .ktcFont(.title3)
                .foregroundColor(KTSColors.textColor.color)
                .background(KTSColors.gray.color)
                .strikethrough(todo.status)
                .frame(maxWidth: .infinity, alignment: .leading)
            DeleteIconView()
                .onTapGesture {
                    deleteAction()
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(KTSColors.gray.color)
        .listRowBackground(KTSColors.background.color)
        .cornerRadius(12)
    }
}
