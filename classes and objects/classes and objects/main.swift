//
//  main.swift
//  classes and objects
//
//  Created by Matt on 6/12/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation

let myCar = Car()
let otherCar = Car(color: "Blue")

print(myCar.color)
print(otherCar.color)

myCar.drive()
otherCar.drive()

print()

let aSelfDrivingCar = SelfDrivingCar()
aSelfDrivingCar.destination = "1 Test Way"

print(aSelfDrivingCar.color)
aSelfDrivingCar.drive()
