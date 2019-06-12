//
//  SelfDrivingCar.swift
//  classes and objects
//
//  Created by Matt on 6/12/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

/*
    - Basic inheritance handling in Swift
 */

// By using ": Car", we make it so that SelfDrivingCar inherits the properties from the Car class
// SelfDrivingCar is now a subclass from the Car superclass
class SelfDrivingCar : Car {
    var destination: String = "1 Test Way"
    
    // Override function
    override func drive() {
        print("Your \(color) self-driving car is now driving to: \(destination)")
    }
    
}
