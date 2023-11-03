//
//  RoundedButton.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Shared
import SwiftUI

struct RoundedButton: View {
    let text: String
    let textColor: KTSColors
    let backgroundColor: KTSColors
    let action: () -> Void

    init(_ text: String,
         textColor: KTSColors = .button,
         backgroundColor: KTSColors = .charcoal,
         action: @escaping () -> Void)
    {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ktsFont(.button)
                .padding()
                .foregroundColor(textColor.color)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(backgroundColor.color, lineWidth: 2)
                )
        }
        .background(backgroundColor.color)
        .cornerRadius(10)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton("Test Text") {}
    }
}
