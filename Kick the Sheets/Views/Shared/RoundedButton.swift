//
//  RoundedButton.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import SwiftUI

struct RoundedButton: View {
    let text: String
    let color: KTSColors
    let action: () -> Void

    init(_ text: String, color: KTSColors = KTSColors.charcoal, action: @escaping () -> Void) {
        self.text = text
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ktsFont(.button)
                .padding()
                .foregroundColor(KTSColors.button.color)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(color.color, lineWidth: 2)
                )
        }
        .background(color.color)
        .cornerRadius(10)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton("Test Text") {}
    }
}
