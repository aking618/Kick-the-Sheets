//
//  CircleCheckmarkView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/1/23.
//

import SwiftUI

struct CircleCheckmarkView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 2)
                .background(Circle().foregroundColor(isChecked ? KTSColors.persianGreen.color : .clear))
            
            if isChecked {
                Path { path in
                    let size: CGFloat = 10
                    let x = CGFloat(15) - size/2 // Center the checkmark horizontally in the circle
                    let y = CGFloat(15) - size/2 // Center the checkmark vertically in the circle
                    path.move(to: CGPoint(x: x, y: y + size/2))
                    path.addLine(to: CGPoint(x: x + size/2, y: y + size))
                    path.addLine(to: CGPoint(x: x + size, y: y))
                }
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(.degrees(isChecked ? 0 : -90))
                .scaleEffect(isChecked ? 1.0 : 0.01)
                .animation(.easeInOut, value: isChecked)
            }
        }
        .frame(width: 30, height: 30)
    }
}


struct CircleCheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CircleCheckmarkView(isChecked: .constant(true))
    }
}
