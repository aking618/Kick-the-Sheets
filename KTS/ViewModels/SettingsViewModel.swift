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
    @Published var showDeleteDataPopup: Bool = false

    func setup() {
        let resetData = SettingsOption(title: "Reset All Data", image: "trash", style: .destructive, action: handleResetData)
        let about = SettingsOption(title: "About", image: "info.circle", style: .generic, action: handleAbout)
        let migrateTodos = SettingsOption(title: "Migrate Unfinished Todos", image: "link", style: .toggle, action: handleMigrateTodos)

        options = [about, migrateTodos, resetData]
    }

    private func handleResetData() {
        showDeleteDataPopup = true
    }

    private func handleAbout() {
        showAboutPopup = true
    }

    private func handleMigrateTodos() {}
}
