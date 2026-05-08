//
//  MeritLogFile.swift
//  MeritCard
//
//  Created by Jonathan Preston on 11/10/2024.
//

import Foundation
import SwiftData

@Model
final class MeritLogFile {
    //@Attribute(.unique)
    var when: Date
    var meritcard: String
    var meritpos: Int
    var transaction: String
    
    init(when: Date = Date(), meritcard: String = "None", meritpos: Int = 0, transaction: String = "None") {
        self.when = when
        self.meritcard = meritcard
        self.meritpos = meritpos
        self.transaction = transaction
    }
}
