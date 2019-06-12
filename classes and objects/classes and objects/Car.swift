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
}
