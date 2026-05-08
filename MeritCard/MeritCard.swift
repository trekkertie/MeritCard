//
//  MeritCard.swift
//  MeritCard
//
//  Created by Jonathan Preston on 07/08/2024.
//

import SwiftUI
import SwiftData

@Model
final class MeritCard {
    @Attribute(.unique) var name: String
    @Attribute(.externalStorage) var logo: Data
    var slogan: String
    var rank: Int
    var count: Int
    var merit: [Merit]
    
    init(name: String = "", logo: Data = Data(), slogan: String = "", rank: Int = 0, count: Int = 0, merit: [Merit] = []) {
        self.name = name
        self.logo = logo
        self.slogan = slogan
        self.rank = rank
        self.count = count
        self.merit = merit
    }
}
