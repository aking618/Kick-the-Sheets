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
            Button(action: doneAction) {
                CircleCheckmarkView(isChecked: $todo.status)
            }

            Text(todo.description)
                .ktsFont(.body)
                .foregroundColor(KTSColors.text.color)
                .strikethrough(todo.status)
                .frame(maxWidth: .infinity, alignment: .leading)
            DeleteIconView()
                .onTapGesture {
                    deleteAction()
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(KTSColors.rowBackground.color)
        .listRowBackground(KTSColors.background.color)
        .listRowSeparator(.hidden)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(KTSColors.border.color, lineWidth: 1)
        )
    }
}
