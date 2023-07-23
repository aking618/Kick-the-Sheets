//
//  SettingsView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/9/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var settingViewModel = SettingsViewModel()

    var body: some View {
        BaseView {
            VStack {
                header
                options
            }
        }
        .foregroundColor(KTSColors.text.color)
        .alert(AboutStrings.title.rawValue, isPresented: $settingViewModel.showAboutPopup) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(AboutStrings.message.rawValue)
        }

        .alert("Delete All Data", isPresented: $settingViewModel.showDeleteDataPopup) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                appState.todoService.deleteAllEntries()
                appState.updateAppState()
            }
        }

        .onAppear {
            settingViewModel.setup()
        }
    }
}

// MARK: - Views

extension SettingsView {
    @ViewBuilder
    private var header: some View {
        Text("Settings")
            .ktsFont(.title2)
            .foregroundColor(KTSColors.text.color)
            .padding()
    }

    @ViewBuilder
    private var options: some View {
        VStack(spacing: 5) {
            List($settingViewModel.options) { $option in
                SettingsOptionRow(option: $option)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
