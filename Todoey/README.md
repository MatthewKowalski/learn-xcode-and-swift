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
  * From the [Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html), this operator is essentially shorthand for a ternary operator that is handling optionals
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

* **guard** keyword ([Description Source](https://stackoverflow.com/a/32256911/8598331))
  * Handles possible errors like an `if let` statement, but has distinct differences:
    * The `else` block must exit the current scope
      * Generally means it must call `return` or terminate the program
    * > `guard` is used to provide early return without requiring nesting of the rest of the function
  * > Use `if let` when the `non-nil` case is valid. Use `guard` when the `nil` case represents some sort of error
  * **Example:**
    ```swift
    if let colorHex = selectedCategory?.color {
        print(colorHex)
    }
    ```
    Becomes something like
    ```swift
    guard let colorHex = selectedCategory?.color else { fatalError() }

    print(colorHex)
    ```