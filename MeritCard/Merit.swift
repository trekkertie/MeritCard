//
//  MeritCard.swift
//  MeritCard
//
//  Created by Jonathan Preston on 07/08/2024.
//


import SwiftData
import SwiftUI

@Model
final class Merit {
    var position: Int
    var allocated: Bool
    var date: Date?
    var comment: String
    
    init(position: Int = 0, allocated: Bool = false, date: Date = .now, comment: String = "") {
        self.position = position
        self.allocated = allocated
        self.date = date
        self.comment = comment
    }
}


