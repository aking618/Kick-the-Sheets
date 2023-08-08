//
//  CircularProgressView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/9/23.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Int
    let total: Int
    let lineWidth: CGFloat

    init(progress: Int, total: Int, _ lineWidth: CGFloat = 10) {
        self.progress = progress
        self.total = total
        self.lineWidth = lineWidth
    }

    var body: some View {
        ZStack {
            incompleteCircle
            completedCircle
            percentageIndicator
        }
        .frame(height: 125)
    }
}

// MARK: - Views

extension CircularProgressView {
    private var incompleteCircle: some View {
        Circle()
            .stroke(
                KTSColors.burntSienna.color.opacity(0.5),
                lineWidth: lineWidth
            )
    }

    private var completedCircle: some View {
        Circle()
            .trim(from: 0, to: percentage)
            .stroke(
                KTSColors.persianGreen.color,
                style: StrokeStyle(
                    lineWidth: lineWidth,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut, value: progress)
    }

    private var percentageIndicator: some View {
        VStack {
            Text(percentageString)
                .foregroundColor(KTSColors.text.color)
                .ktsFont(.title)

            Text("\(progress)/\(total)")
                .foregroundColor(KTSColors.text.color)
                .ktsFont(.title3)
        }
    }
}

// MARK: - Computed Properties

extension CircularProgressView {
    var percentage: Double {
        guard total > 0 else { return 0 }

        return Double(progress) / Double(total)
    }

    var percentageString: String {
        guard total > 0 else { return "0%" }

        let percentage = percentage * 100
        return "\(percentage.formatted(.number.precision(.fractionLength(0))))%"
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 5, total: 8)
    }
}
