//
//  Data.swift
//  Todoey
//
//  Created by Matt on 6/22/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

// NOTE: This is just a sample/testing class -> used as an introduction to Realm

import Foundation
import RealmSwift

// Inherits "Object" -> a class that's used to define Realm Model Objects -> A superclass that enables us to persist our Data-class
class Data: Object {
    // Need to use keyword "dynamic" since we are using Realm
        // "dynamic" -> a "declaration modifier" -> tells the runtime to use Dynamic Dispath over the standard, Static Dispatch
            // Allows the variable to be monitored for change at runtime during runtime
            // Ex.) if the user changes the value of "name" while the app is running, it allows Realm to dynamically update the changes in our database
        // "dynamic" comes from the Objective-C APIs -> use @objc keyword
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
