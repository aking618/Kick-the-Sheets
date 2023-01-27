//
//  KTSColors.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import Foundation
import SwiftUI

enum KTSColors {
    case darkPurple
    case purple
    case lightPurple
    case red
    case green
    case textColor
    
    var color: Color {
        switch self {
        case .darkPurple:
            return Color.fromRGBA(red: 36, green: 23, blue: 34)
        case .purple:
            return Color.fromRGBA(red: 43, green: 30, blue: 41)
        case .lightPurple:
            return Color.fromRGBA(red: 60, green: 47, blue: 58)
        case .red:
            return Color.fromRGBA(red: 177, green: 78, blue: 78)
        case .green:
            return Color.fromRGBA(red: 0, green: 85, blue: 0)
        case .textColor:
            return Color.fromRGBA(red: 255, green: 255, blue: 255)
        }
    }
}

extension Color {
    static func fromRGBA(red r: Double, green g: Double, blue b: Double, opacity a: Double = 100) -> Color {
        Color(red: r / 255.0, green: g / 255.0, blue: b / 255.0, opacity: a / 100.0)
    }
}
