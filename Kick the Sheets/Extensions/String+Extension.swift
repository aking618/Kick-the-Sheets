//
//  String+Extension.swift
//  Kick the Sheets
//
//  Created by Ayren King on 2/4/23.
//

import Foundation

extension String {
    func caseInsensitiveContains(_ otherString: String) -> Bool {
        let trimmedString = otherString.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty { return true }

        return self.lowercased().contains(trimmedString.lowercased())
    }
}
