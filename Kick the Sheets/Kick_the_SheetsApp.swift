//
//  Kick_the_SheetsApp.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import SwiftUI

@main
struct Kick_the_SheetsApp: App {
    @StateObject var appState: AppState = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
