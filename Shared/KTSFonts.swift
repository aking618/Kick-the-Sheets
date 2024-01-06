//
//  KTSFonts.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/8/23.
//

import SwiftUI

public struct KTSFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case title
        case title2
        case title3
        case body
        case italic
        case caption
        case button
    }

    var textStyle: TextStyle

    public func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(fontName, size: scaledSize))
    }

    private var fontName: String {
        switch textStyle {
        case .title, .title2, .title3:
            "Andika-Bold"
        case .body, .button:
            "Andika"
        case .caption:
            "Andika-BoldItalic"
        case .italic:
            "Andika-Italic"
        }
    }

    private var size: CGFloat {
        switch textStyle {
        case .title:
            26
        case .title2:
            22
        case .title3, .button:
            18
        case .body, .italic:
            16
        case .caption:
            14
        }
    }
}

public extension View {
    func ktsFont(_ textStyle: KTSFont.TextStyle) -> some View {
        modifier(KTSFont(textStyle: textStyle))
    }
}
