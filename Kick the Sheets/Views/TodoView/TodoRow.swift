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
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: "terminal")
                .scaledToFill()
                .foregroundColor(KTSColors.textColor.color)
                .background(
                    Rectangle()
                        .frame(width: 36, height: 36)
                        .foregroundColor(KTSColors.lightPurple.color)
                        .cornerRadius(5)
                )
                .frame(width: 48, height: 48)
            
            Text(todo.description)
                .foregroundColor(KTSColors.textColor.color)
        }
        .background(KTSColors.darkPurple.color)
        .listRowBackground(KTSColors.darkPurple.color)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
            TodoRow(todo: .constant(.init(id: 0, dayId: 0, description: "This is a test description", status: false)))
    }
}
