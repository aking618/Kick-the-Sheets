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
        .aboutAlert(isPresented: $settingViewModel.showAboutPopup)
        .deleteAllDataAlert(isPresented: $settingViewModel.showDeleteDataPopup, appState)
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

// MARK: - Alerts

private extension View {
    @ViewBuilder
    func aboutAlert(isPresented: Binding<Bool>) -> some View {
        alert(AboutStrings.title.rawValue, isPresented: isPresented) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(AboutStrings.message.rawValue)
        }
    }

    @ViewBuilder
    func deleteAllDataAlert(isPresented: Binding<Bool>, _ appState: AppState) -> some View {
        alert("Delete All Data", isPresented: isPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                appState.todoService.deleteAllEntries()
                appState.updateAppState()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
