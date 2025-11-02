//
//  DbDay.swift
//  Database
//
//  Created by Ayren King on 1/26/23.
//

import Foundation
import SQLite

struct DbDay {
    let table = Table("days")
    let id = SQLite.Expression<Int64>("id")
    let status = SQLite.Expression<Bool>("status")
    let day = SQLite.Expression<Date>("day")
}
