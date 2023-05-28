//
//  SettingsView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/9/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()

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
            List($viewModel.options) { $option in
                SettingsOptionRow(option: $option)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }

    var body: some View {
        BaseView {
            VStack {
                header
                options
            }
        }
        .foregroundColor(KTSColors.text.color)
        .onAppear {
            viewModel.setup()
        }
        .aboutPagePopup($viewModel.showAboutPopup)
        .deleteAllDataAlert($viewModel.showDeleteDataPopup)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
