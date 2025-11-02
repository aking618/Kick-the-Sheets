//
//  EmptyListViewModifier.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/6/23.
//

import SwiftUI

struct EmptyDataModifier<Placeholder: View>: ViewModifier {
    let items: [Any]
    let placeholder: Placeholder

    func body(content: Content) -> some View {
        if !items.isEmpty {
            content
        } else {
            placeholder
        }
    }
}
