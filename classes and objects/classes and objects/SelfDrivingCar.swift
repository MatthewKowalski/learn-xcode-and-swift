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
    // The '?' (an Optional in Swift) states that the value may contain a nil (null) value
    var destination: String?
    
    // Override function
    override func drive() {
        // Optional Binding - check & make sure that the destination property has a value before it gets used
            // Creates a new keyword (e.g., userDestination) and sets it equal to the value of the optional (e.g., destination)
            // The lines of code between the { } only get fired off when the optional is not nil
        // By using Optional Binding, we don't need to force-unwrap (!) anything -> essentially "safer" than just force-unwrapping
        if let userDestination = destination {
            // The '!' "force-unwraps" the optional --> Basically implies that we are certain the value is not nil (null)
            //print("Your \(color) self-driving car is now driving to: \(destination!)")
            
            print("Your \(color) self-driving car is now driving to: \(userDestination)")
        }
        
    }
    
    
    
}
