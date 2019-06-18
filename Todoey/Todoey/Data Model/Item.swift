//
//  Item.swift
//  Todoey
//
//  Created by Matt on 6/18/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

class Item {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
