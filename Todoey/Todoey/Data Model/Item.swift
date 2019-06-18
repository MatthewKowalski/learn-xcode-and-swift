//
//  Item.swift
//  Todoey
//
//  Created by Matt on 6/18/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

// Need our object to inherit the "rules" of being Encodable & Decodable so that we can use it in said manner (make it conform to both)
//class Item: Encodable, Decodable {
class Item: Codable {   // *** NOTE: Can use "Codable" to inherit/conform to both Encodable and Decodable ***
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
}
