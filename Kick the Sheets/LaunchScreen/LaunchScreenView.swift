//
//  LaunchScreenView.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/16/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

    @State private var firstAnimation = false
    @State private var secondAnimation = false
    @State private var startFadeoutAnimation = false

    @ViewBuilder
    private var image: some View {
        Image("Logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding([.leading, .trailing], 48)
            .animation(.spring())
    }

    @ViewBuilder
    private var backgroundColor: some View {
        KTSColors.background.color.ignoresSafeArea()
    }

    var body: some View {
        ZStack {
            backgroundColor
            image
        }
        .onAppear {
            launchScreenState.dismiss()
        }
    }

    private func updateAnimation() {
        switch launchScreenState.state {
        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }
        case .secondStep:
            if secondAnimation == false {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }
        case .finished:
            break
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
