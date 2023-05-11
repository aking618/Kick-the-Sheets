//
//  SettingsOption.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/9/23.
//

import Foundation

struct SettingsOption: Identifiable {
    let id: UUID = UUID()
    let title: String
    let image: String
    let style: OptionStyle
    let action: (() -> Void)
    
    
    enum OptionStyle {
        case generic
        case toggle
        case destructive
    }
}
