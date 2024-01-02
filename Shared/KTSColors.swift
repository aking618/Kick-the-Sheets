//
//  KTSColors.swift
//  Kick the Sheets
//
//  Created by Ayren King on 1/26/23.
//

import SwiftUI

public enum KTSColors {
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
        switch self {
        case .text:
            .text
        case .placeholderText:
            .placeholderText
        case .iconBorder:
            .iconBorder
        case .charcoal:
            .charcoal
        case .persianGreen:
            .persianGreen
        case .saffron:
            .saffron
        case .sandyBrown:
            .sandyBrown
        case .burntSienna:
            .burntSienna
        case .button:
            .button
        case .background:
            .background
        case .rowBackground:
            .rowBackground
        case .border:
            .border
        case .tabColor:
            .tab
        }
    }
}
