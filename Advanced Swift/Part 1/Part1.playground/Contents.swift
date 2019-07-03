import Foundation

/*
    The purpose of this playground is to mess around and learn the fundamentals of Setters, Getters, and Observed Properties
 */

// Observed Property -> In this case, 10 is the "default" value
var pizzaInInches: Int = 10 {
    // Set Property Observers

    // Gets triggered right before the value gets set
    willSet {
        // Inside of willSet, we get access to:     newValue
        //print(newValue)
        
        //print(pizzaInInches) // In this case, gives us the "old value" (value before change)
    }
    
    // Gets triggered right after the value gets set
        // I've seen didSet before in the "Todoey" project -> see README.md for "Todoey"
    didSet {
        // Inside of didSet, we get access to:      oldValue
        //print(oldValue)
        
        //print(pizzaInInches) // In this case, gives us the "new value" (value after change"
        
        if(pizzaInInches > 18) {
            print("Invalid size specified, pizzaInInches set to 18.")
            pizzaInInches = 18
            print("New Size: \(pizzaInInches)")
        }
        
    }
    
}

pizzaInInches = 33

var numOfPeople: Int = 6
let slicesPerPerson: Int = 4

// Computed Property - get-only
//var numberOfSlices: Int {
//    return pizzaInInches - 4    // Essentially acting as a "Getter" -> this is a sort of "shorthand"
//
//    // If we don't specify a set-block, the property is "get-only" -> i.e., it cannot be set (Read Only)
//}

// Computed Property - get-only
var numOfSlices: Int {
    // This code is run when another piece of code tries to "get" its value
    get {
        return pizzaInInches - 4
    }
}

var numOfPizza: Int {
    get {
        let numPeopleFedPerPizza = numOfSlices / slicesPerPerson
        return numOfPeople / numPeopleFedPerPizza
    }
    
    set {
        let totalSlices = numOfSlices * newValue
        numOfPeople = totalSlices / slicesPerPerson
    }
}

numOfPizza = 4

print(numOfPeople)
