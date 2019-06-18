import UIKit

let defaults = UserDefaults.standard

defaults.set(0.24, forKey: "volume")
defaults.set(true, forKey: "musicOn")
defaults.set("Matt", forKey: "playerName")
defaults.set(Date(), forKey: "appLastOpenedByUser")

// Can save collections
let array = [1, 2, 3]
defaults.set(array, forKey: "anArray")

let dict = ["name" : "Matthew"]
defaults.set(dict, forKey: "aDict")

// --- Retrieve ---
let volume = defaults.float(forKey: "volume")
let appLastOpen = defaults.object(forKey: "appLastOpenedByUser")

// Retrieve the array
let anArray = defaults.array(forKey: "anArray") as! [Int]
// Retrieve the dictionary
let aDict = defaults.dictionary(forKey: "aDict")
