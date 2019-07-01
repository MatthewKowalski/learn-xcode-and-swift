//
//  Category.swift
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
class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    
    // Specify a relationship in Realm (similar to how we had it in CoreData
    // "List" comes from Realm -> basically a container type
    let items = List<Item>()
}
