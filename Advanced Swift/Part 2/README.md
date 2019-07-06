# Advanced Swift - Part 2

---
## Purpose
The second part of the "Advanced Swift" section will serve as a place to keep my notes regarding Swift as I work through building the project. The primary project (Calculator app) for this part will not be served remotely in this repository as the skeleton was acquired via the Udemy Course (below) and I only plan to keep projects that I worked on from the start on here.

Follows the [Udemy Course](https://www.udemy.com/ios-12-app-development-bootcamp/)

---
## Interesting Concepts (Notes)
A section to list any new, interesting concepts that I may come across while working on this part's project.

### Swift **Struct**s vs. **Class**es
1. Inheritance is reserved for Classes
   * You cannot inherit from a `struct`
   * You cannot subclass within a `struct`
2. Structs live on the Stack
3. Classes live in the Heap w/ a reference in the Stack
4. "Structs are value types"
   * Store the actual data values
   * If we copied a `struct`, the new copy would have exactly the same values
5. "Classes are reference types"
   * Store reference to a block of memory
   * If we copied a `class`, only the reference is copied

### Structs    
* **mutating** keyword for a `struct`
  * If we are going to have a function that changes something about the `struct`, say a property value, we need to mark the function with the `mutating` keyword
    * `struct` is immutable by default (because a `struct` cannot tell in advance if it will be mutable or immutable -> `var` or `let`), therefore we need to create a new copy of the struct when we call a function that mutates it
    * There is a good breakdown of this on [stackoverflow](https://stackoverflow.com/a/24035861/8598331)