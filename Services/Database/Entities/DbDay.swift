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
    let id = Expression<Int64>("id")
    let status = Expression<Bool>("status")
    let day = Expression<Date>("day")
}
