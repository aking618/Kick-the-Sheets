//
//  KTSFonts.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/8/23.
//

import SwiftUI

struct KTSFont: ViewModifier {
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

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(fontName, size: scaledSize))
    }
    
    private var fontName: String {
        switch textStyle {
        case .title, .title2, .title3:
            return "Andika-Bold"
        case .body, .button:
            return "Andika"
        case .caption:
            return "Andika-BoldItalic"
        case .italic:
            return "Andika-Italic"
        }
    }
    
    private var size: CGFloat {
        switch textStyle {
        case .title:
            return 26
        case .title2:
            return 22
        case .title3, .button:
            return 18
        case .body, .italic:
            return 16
        case .caption:
            return 14
        }
    }
}

extension View {
    func ktsFont(_ textStyle: KTSFont.TextStyle) -> some View {
        modifier(KTSFont(textStyle: textStyle))
    }
}
