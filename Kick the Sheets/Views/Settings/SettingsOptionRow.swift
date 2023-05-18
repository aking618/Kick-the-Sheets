//
//  SettingsOptionRow.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/14/23.
//

import Foundation
import SwiftUI

struct SettingsOptionRow: View {
    @Binding var option: SettingsOption

    @State var tapped: Bool = false

    var body: some View {
        HStack {
            Image(systemName: option.image)
            Text(option.title)
                .foregroundColor(KTSColors.textColor.color)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(tapped ? KTSColors.rowBackground.color.opacity(0.5) : KTSColors.rowBackground.color)
        .listRowBackground(KTSColors.background.color)
        .listRowSeparator(.hidden)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(KTSColors.border.color, lineWidth: 1)
        )
        .scaleEffect(tapped ? 0.95 : 1)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                tapped.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    tapped = false
                }
            }

            option.action()
        }
    }
}