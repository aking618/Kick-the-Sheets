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
    
    var percentage: Double {
        guard total > 0 else { return 0}
        
        return Double(progress) / Double(total)
    }
    
    var percentageString: String {
        guard total > 0 else { return "0%"}
        
        let percentage = percentage * 100
        return "\(percentage.formatted(.number.precision(.fractionLength(0))))%"
    }
    
    init(progress: Int, total: Int, _ lineWidth: CGFloat = 10) {
        self.progress = progress
        self.total = total
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    KTSColors.burntSienna.color.opacity(0.5),
                    lineWidth: lineWidth
                )
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

            VStack{
                Text(percentageString)
                    .ktcFont(.title)
                
                Text("\(progress)/\(total)")
                    .ktcFont(.title3)
            }
        }
        .frame(height: 125)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 5, total: 8)
    }
}
