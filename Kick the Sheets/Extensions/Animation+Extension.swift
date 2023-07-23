//
//  Animation+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 5/7/23.
//

import SwiftUI

extension AnyTransition {
    static var leadingSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .leading)
        )
    }

    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing)
        )
    }
}
