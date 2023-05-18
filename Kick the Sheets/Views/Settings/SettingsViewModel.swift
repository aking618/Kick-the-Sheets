//
//  SettingsViewModel.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/9/23.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var options: [SettingsOption] = []
    @Published var showAboutPopup: Bool = false

    func setup() {
        let resetData = SettingsOption(title: "Reset All Data", image: "trash", style: .destructive, action: handleResetData)
        let about = SettingsOption(title: "About", image: "info.circle", style: .generic, action: handleAbout)
        let darkMode = SettingsOption(title: "Dark Mode", image: "moon", style: .toggle, action: handleDarkMode)

        options = [resetData, about, darkMode]
    }

    private func handleResetData() {}

    private func handleAbout() {
        showAboutPopup = true
    }

    private func handleDarkMode() {}
}
