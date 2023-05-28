//
//  KTSColors.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Foundation
import SwiftUI

enum KTSColors: String {
    case text

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

    var color: Color {
        switch self {
        case .text:
            return Color.fromAsset(color: .text)

        case .iconBorder:
            return Color.fromAsset(color: .iconBorder)
        case .charcoal:
            return Color.fromRGBA(red: 38, green: 70, blue: 83)
        case .persianGreen:
            return Color.fromRGBA(red: 42, green: 157, blue: 143)
        case .saffron:
            return Color.fromRGBA(red: 233, green: 196, blue: 106)
        case .sandyBrown:
            return Color.fromRGBA(red: 244, green: 162, blue: 97)
        case .burntSienna:
            return Color.fromRGBA(red: 231, green: 111, blue: 81)
        case .background:
            return Color.fromAsset(color: .background)
        case .rowBackground:
            return Color.white
        case .button:
            return .white
        case .border:
            return Color.fromRGBA(red: 240, green: 240, blue: 240)
        }
    }
}

extension Color {
    static func fromRGBA(red r: Double, green g: Double, blue b: Double, opacity a: Double = 100) -> Color {
        Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0, opacity: a / 100.0)
    }

    static func fromAsset(color: KTSColors) -> Color {
        let uiColor = UIColor(named: color.rawValue) ?? .red
        return Color(uiColor: uiColor)
    }
}
