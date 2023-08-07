//
//  UIDevice+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 8/6/23.
//

import UIKit

extension UIDevice {
    var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
