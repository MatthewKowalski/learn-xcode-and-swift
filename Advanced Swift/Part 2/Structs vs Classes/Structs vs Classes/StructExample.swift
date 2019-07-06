//
//  StructExample.swift
//  Structs vs Classes
//
//  Created by Matt on 7/6/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation
// Structs cannot subclass (inherit) -> Inheritance is reserved for Classes
struct StructHero {
    // Don't get any errors if an init() method isn't specified -> struct's have a "given" initializer
    var name: String
    var universe: String
    
    func reverseName() -> String {
        return String(name.reversed())
    }
    
    // If our function mutates the struct (which is immutable by default), we mark it with the "mutating" keyword
        // Upon function call, a new copy of the struct is made
    mutating func changeToReverse() {
        name = String(name.reversed())
    }
}

//let hero = StructHero(name: "Iron Man", universe: "Marvel")   // valid -> constructor is implied
