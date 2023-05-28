//
//  AboutView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/19/23.
//

import SwiftUI

struct AboutView: View {
    private let title = "Kicking the Sheets"
    private let message = """
    Welcome to Kicking the Sheets! I have designed this app to bring an exciting twist to the task completion process by gamifying it.

    Every day you successfully complete all your tasks, you'll build up a streak, adding to your overall progress. The longer your streak, the more accomplished you'll feel, and the closer you'll get to your goals.

    By incorporating gamification into task management, I aim to make productivity fun and rewarding. You'll find yourself motivated and driven to conquer your to-do list day after day.

    Join us on this journey and transform the way you approach tasks. Let's turn productivity into a game and unlock your full potential!
    """

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack {
                    Text(title)
                        .foregroundColor(KTSColors.text.color)
                        .ktsFont(.title3)
                    Text(message)
                        .foregroundColor(KTSColors.text.color)
                        .ktsFont(.body)
                }
            }
            DeleteIconView()
        }
        .frame(height: 500)
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
        .background(KTSColors.sandyBrown.color)
        .cornerRadius(30.0)
        .padding(30)
        .border(KTSColors.border.color)
    }
}
