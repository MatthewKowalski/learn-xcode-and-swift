import Foundation

// Creation #1
let tuple1 = ("Matt", 12)

print(tuple1.0)
print(tuple1.1)

// Creation #2
let tuple2 = (name: "Matt", age: 99)

print(tuple2.name)
print(tuple2.age)

// Creation #3
let tuple3: (name: String, age: Int)
//tuple3.name = "Matt"
//tuple3.age = 99
tuple3 = (name: "Matt", age: 89)    // initialize the tuple in one line

print("\(tuple3.name) is \(tuple3.age) years old!")
