//
//  RoundedButton.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import SwiftUI

struct RoundedButton: View {
    
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
                Text(text)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(KTSColors.textColor.color)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(KTSColors.red.color, lineWidth: 2)
                )
            }
        .background(KTSColors.red.color)
        .cornerRadius(10)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton("Test Text") {}
    }
}
