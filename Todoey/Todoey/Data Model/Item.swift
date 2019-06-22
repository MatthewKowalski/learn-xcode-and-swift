//
//  Item.swift
//  Todoey
//
//  Created by Matt on 6/22/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import Foundation
import RealmSwift

/*
    Because we used the terms "Item" and "Category" for our entities in our DataModel.xcdatamodeld for CoreData & had their "Codegen" attribute set to "Class Definition",
    we need to either delete the DataModel.xcdatamodeld file or change the "Codegen" property to "Manual/None"
 */
class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // Specify a relationship in Realm (similar to how we had it in CoreData
    // This is the inverse relationship that points back to Category
    // "LinkingObjects" are auto-updating containers that represent 0 or more objects that are linked to its owning model object
        // fromType: Category.self (gets the Category type), property: the name of the forward relationship (in Category)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
