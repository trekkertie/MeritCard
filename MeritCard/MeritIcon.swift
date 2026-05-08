//
//  MeritIcon.swift
//  MeritCard
//
//  Created by Jonathan Preston on 28/11/2025.
//

import Foundation
import SwiftData

@Model
final class MeritIcon {
    var iconData: Data

    init(iconData: Data = Data()) {
        self.iconData = iconData
    }
}

