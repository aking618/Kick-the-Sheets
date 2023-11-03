//
//  KTSColors.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Foundation
import SwiftUI

public enum KTSColors: String {
    case text
    case placeholderText

    case iconBorder

    case charcoal
    case persianGreen
    case saffron
    case sandyBrown
    case burntSienna

    case button
    case background
    case rowBackground
    case border
    case tabColor

    public var color: Color {
        Color.fromAsset(color: self)
    }
}

public extension Color {
    static func fromRGBA(red r: Double, green g: Double, blue b: Double, opacity a: Double = 100) -> Color {
        Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0, opacity: a / 100.0)
    }

    static func fromAsset(color: KTSColors) -> Color {
        let uiColor = UIColor(named: color.rawValue) ?? .red
        return Color(uiColor: uiColor)
    }
}
