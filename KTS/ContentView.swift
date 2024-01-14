//
//  ContentView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Services
import Shared
import SwiftUI
import WidgetKit

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            tabView
                .padding(.bottom)
                .background(KTSColors.background.color)
            Divider()
            bottomNavBar
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            appState.showMigrationPopup = appState.todoMigrationService.shouldShowPopup()
        }
        .alert("Migrate Unfinished Todos", isPresented: $appState.showMigrationPopup) {
            Button("Migrate") {
                appState.todoMigrationService.migrateTodos(currentDayId: appState.currentDayId)
                appState.updateAppState()
            }
            Button("Cancel", role: .cancel) {}
        }
        .onChange(of: scenePhase) { newPhase in
            if case ScenePhase.background = newPhase {
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

// MARK: - Views

extension ContentView {
    @ViewBuilder
    private var tabView: some View {
        switch appState.selectedTab {
        case .home:
            DayView()
                .tag(Tab.home)
                .transition(.leadingSlide)
        case .calendar:
            Home(viewModel: HomeViewModel(todoService: appState.todoService, days: $appState.days))
                .tag(Tab.calendar)
                .transition(appState.calendarTransition)
        case .settings:
            SettingsView()
                .tag(Tab.settings)
                .transition(.backslide)
        }
    }

    private var bottomNavBar: some View {
        BottomNavigationBar()
            .background(AnimatedIndicator(selectedTab: $appState.selectedTab))
            .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
