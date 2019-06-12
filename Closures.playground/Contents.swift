import UIKit

// n1:          Int
// n2:          Int
// operation:   Function
    // "operation" is essentially a function that takes in two Ints as params and returns an Int
func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    
    // Pass in the two ints into the passed in function (which we call operation)
    return operation(n1, n2)
}

func add(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

func multiply(n1: Int, n2: Int) -> Int {
    return n1 * n2
}

// Pass in the add function as a parameter
calculator(n1: 2, n2: 3, operation: add)
calculator(n1: 2, n2: 3, operation: multiply)

// Pass in a closure
calculator(n1: 2, n2: 3, operation: { (no1: Int, no2: Int) -> Int in
    return no1 * no2
})

// Pass in a closure w/ inferred data types of the params
calculator(n1: 2, n2: 3, operation: { (no1, no2) -> Int in
    return no1 + no2
})

// Pass in a closure w/ inferred data types of BOTH the params & the return type
calculator(n1: 5, n2: 5, operation: { (no1, no2) in
    return no1 * no2
})

// Can do the same of above & disregard the "return" keyword as it's being inferred
calculator(n1: 4, n2: 5, operation: { (no1, no2) in no1 * no2 })

// Can use anonymouse params -> $0, $1, etc... to further cut down code
let x = calculator(n1: 9, n2: 9, operation: {$0 * $1})
print(x)

// In Swift, if the last param is a Closure, then we can remove the param. name & just have the closure trail at the end
let y = calculator(n1: 8, n2: 8) {$0 * $1}
print(y)

// ------------------------------------

// WANT to add 1 to every element in the array w/o a for-loop
let array = [10, 11, 12, 13, 14, 15]

func addOne(n1: Int) -> Int {
    return n1 + 1
}

//array.map(addOne)
//let a = array.map({ (n1) in n1 + 1 })
let b = array.map{$0 + 1}
print(b)



