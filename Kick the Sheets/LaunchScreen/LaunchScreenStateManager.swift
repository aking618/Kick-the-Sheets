//
//  LaunchScreenStateManager.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/16/23.
//

import Foundation

final class LaunchScreenStateManager: ObservableObject {
    @MainActor
    @Published
    private(set) var state: LaunchScreenStep = .firstStep

    @MainActor
    func dismiss() {
        Task {
            try? await Task.sleep(for: Duration.seconds(0.5))
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1.5))

            self.state = .finished
        }
    }
}
