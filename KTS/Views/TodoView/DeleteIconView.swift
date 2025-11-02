//
//  DeleteIconView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/1/23.
//

import Shared
import SwiftUI

struct DeleteIconView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 7.5, y: 7.5))
            path.addLine(to: CGPoint(x: 22.5, y: 22.5))
            path.move(to: CGPoint(x: 22.5, y: 7.5))
            path.addLine(to: CGPoint(x: 7.5, y: 22.5))
        }
        .stroke(KTSColors.burntSienna.color, lineWidth: 2)
        .frame(width: 30, height: 30)
    }
}

struct DeleteIconView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteIconView()
    }
}
