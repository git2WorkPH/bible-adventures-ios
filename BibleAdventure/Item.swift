//
//  Item.swift
//  BibleAdventure
//
//  Created by jc on 6/7/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
