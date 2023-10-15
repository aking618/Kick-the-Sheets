//
//  BaseView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 12/22/22.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    let color: Color
    let content: Content

    public init(color: Color = KTSColors.background.color, @ViewBuilder content: () -> Content) {
        self.color = color
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                color.ignoresSafeArea()
                content
                    .frame(width: geometry.size.width * 0.8)
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView {
            Text("Hello World")
        }
    }
}
