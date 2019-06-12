//
//  Car.swift
//  classes and objects
//
//  Created by Matt on 6/12/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

enum CarType {
    case sedan
    case coupe
    case hatchback
}

class Car {
    
    var color: String = "Black"
    var numSeats: Int = 5
    var carType: CarType = .coupe
    
    // Designated Initializer -- makes sure that all properties of the object have values
    init() {
        // Self == equiv. to " this.<> " in Java
        //self.color = color
    }
    
    // Convience (Optional) Initializer
    convenience init (color: String) {
        self.init() // Must call the Designated Initializer first
        self.color = color
    }
    
    // Simple method
    func drive() {
        print("Your \(color) car is now driving")
    }
    
}
