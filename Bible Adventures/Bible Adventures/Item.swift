//
//  Item.swift
//  Bible Adventures
//
//  Created by jc on 2/7/2026.
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
