# Todoey - A Todo App

---
## Purpose
Design a "todo" app to learn the fundamentals of Core Data, Realm, and User Defaults.

This project has a large focus on storage, particularly Persistent Local Data Storage.

Follows the [Udemy Course](https://www.udemy.com/ios-12-app-development-bootcamp/)

---
## Interesting Concepts
A section to list any new, interesting concepts that I may come across while working on this example project.

* iOS applications are contained in their own **"sandbox"** environments and therefore cannot directly affect the OS
* **didSet** keyword for Optionals
  * Runs code in between its `{ }` once the variable it is attached to gets set with a value (meaning it is no longer `nil`)
  * **Example:**
  ```swift
  var selectedCategory: Category? {
      didSet {
          loadItems()
      }
  }
  ```

* **Nil-Coalescing Operator**
  * Handles the possibility of an optional being `nil` in one line
  * From the [Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html), this operator is essentially shorthand for a ternary operator that is handling options
  * **Example:**
  ```swift
  // Ternary Operator

  return categories == nil ? categories!.count : 1
  ```
  Becomes
  ```swift
  // Nil-Coalescing Operator

  return categories?.count ?? 1
  ```