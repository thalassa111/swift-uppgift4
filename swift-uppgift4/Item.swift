//
//  Item.swift
//  swift-uppgift4
//
//  Created by Dennis on 2024-11-12.
//

import Foundation
import SwiftData

@Model
final class TodoItem  {
    var text: String
    var done: Bool
    
    init(text: String, done: Bool){
        self.text = text
        self.done = done
    }
}
