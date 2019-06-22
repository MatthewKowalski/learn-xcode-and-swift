//
//  ViewController.swift
//  Todoey
//
//  Created by Matt on 6/17/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

// Add UISearchBarDelegate to allow this ViewController to be the delegate for the UISearchBar element
class TodoListViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var itemArray = ["Eat", "Code", "Sleep"]
    
    // Init a new Realm
    let realm = try! Realm()
    
    // Empty array of Item objects
    //var itemArray = [Item]()
    
    // **--- INTRODUCTION OF Realm ---**
    // Need to use type Results (an auto-updating container type) as it is what is returned from pulling from the Realm DB
    var todoItems: Results<Item>?
    
    // An Optional Category that will be nil until it is set in the CategoryViewController
    var selectedCategory: Category? {
        // ** "didSet" keyword -> runs code in its { } as soon as the selectedCategory variable gets set with a value
        didSet {
            // Get items from storage and load them
            loadItems()
        }
    }
    
    // Path to Documents directory in the applicaton's directory -> the path is specified for our custom "Items.plist" file (UserDefaults)
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // *-- INTRODUCTION OF Core Data --*
    // "shared" returns the singleton app instance -> refers to our live application (when the app is running) -> we then cast is as our AppDelegate
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Create UserDefaults object
        // UserDefaults -> where you store key-value pairs persistently across launches of our app
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
        // *-- CoreData sqllite file in this path, but /Library/Application Support/ instead of /Documents/ -> open .sqlite file with a SQLite program --*
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // Load in the array currently saved in our storage
            // ** Use "if let" to make sure that this array exists and is not nil -> if it DOES exist, then set itemArray = items (the array we pulled from storage) **
//        if let items = defaults.array(forKey: "todoListArray") as? [Item] {
//            itemArray = items
//        }
        
        // Set the delegate for the searchBar
        searchBar.delegate = self
        
    }
    
    // MARK:- TableView Datasource Methods
    // Essentially required to show the cells in the TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the # of cells we want
        //return itemArray.count
        
        // **--- INTRODUCTION OF Realm ---**
        return todoItems?.count ?? 1
    }
    
    // This gets run for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get reference to the cell(s) within the TableView by their "Reuse Identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //let item = itemArray[indexPath.row]
        
        // **--- INTRODUCTION OF Realm ---**
        // If todoItems is not nil, grab the item at indexPath.row & run the code
        if let item = todoItems?[indexPath.row] {
            // Set the body/text of the cell to the String at the corresponding index in the itemArray
            cell.textLabel?.text = item.title
            
            // Set the accessory marker depending on the value of the "done" boolean for the Item object(s)
            cell.accessoryType = (item.done) ? .checkmark : .none
        } else {
            // It is nil
            cell.textLabel?.text = "No Items Added"
        }
        
        // Set the body/text of the cell to the String at the corresponding index in the itemArray
        //cell.textLabel?.text = item.title
        
        // Set the accessory marker depending on the value of the "done" boolean for the Item object(s)
        //cell.accessoryType = (item.done) ? .checkmark : .none
        
        return cell
    }
    
    // MARK:- TableView Delegate Methods
    
    // Function/Event that gets called when a cell within the TableView is "clicked" on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        // IF we wanted to delete items (while using Core Data0
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        // Set the "done" variable to the opposite of what it is now
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done    // Needed for our CoreData implementation

        // NOTE: No longer need this as we handle it in the above method
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = (cell?.accessoryType == .checkmark) ? .none : .checkmark

        // Save the array to reflect updated data && reload the TableView (inside the method)
        //saveItems()   // Needed for our CoreData implm.
        
        // **--- INTRODUCTION OF Realm ---**
        // If todoItems is NOT nil, access the Item object at indexPath.row & execute the code in { }
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    // Set the "done" variable to the opposite of what it is now
                    item.done = !item.done
                    //realm.delete(item)  // Can use this to delete an Item object from our Realm DB
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        // Reload the TableView data to reflect new data
        tableView.reloadData()
        
        // Make it so that the selected row/cell doesn't stay highlighted upon a click
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK:- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Want a UIAlert to show with a text field so that the user can write in their new item
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        // Create a local textField variable so that we can get the alert TextField from the closure
        var textField = UITextField()
        
        // Add a TextField to the alert
        alert.addTextField { (alertTextField) in
            // The placeholder text for the TextField
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen once the user clicks the "Add Item" button on the UI Alert
            
            // Check to make sure there is actually content inside of the TextField
                // If the user simply hits "Add Item" w/o writing anything, the TextField.text length is 0
            if(textField.text!.count != 0) {
                
                //self.itemArray.append(textField.text!)
                //self.itemArray.append(Item(title: textField.text!, done: false))
                
                // *-- INTRODUCTION OF Core Data --*
//                let newItem = Item(context: self.context)
//                newItem.title = textField.text!
//                newItem.done = false
//                // Set the parent category of the Item to the currently selected category
//                newItem.parentCategory = self.selectedCategory
//
//                self.itemArray.append(newItem)
                
                // **--- INTRODUCTION OF Realm ---**
                
                if let currentCategory = self.selectedCategory {
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            // Add the item to the categories "list of items"
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error saving context, \(error)")
                    }
                }
                
                self.tableView.reloadData()
                
                // Save the updated array to our UserDefaults -> key-value pair
                // ** NOTE: UserDefaults rejects this & throws an error as we are trying to set an array of custom objects to the plist of UserDefaults -> UserDefaults doesn't handle custom objects like this & throws the error **
                //self.defaults.set(self.itemArray, forKey: "todoListArray")
                
                // Save the array to reflect updated data && reload the TableView (inside the method)
                //self.saveItems()  // CoreData
                
            }
            
        }
        
        // Add the action to the alert
        alert.addAction(action)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- Model Manipulation Methods
    
//    func saveItems() {
//        // Use encoder instead of UserDefaults due to the above issue we face/discussed
////        let encoder = PropertyListEncoder()
////
////        do {
////            let data = try encoder.encode(itemArray)
////
////            // Write the data to our data file path
////            try data.write(to: dataFilePath!)
////
////        } catch {
////            print("Error encoding item array, \(error)")
////        }
//
//        // *-- INTRODUCTION OF Core Data --*
//        do {
//            // Try to save to our persistent storage
//            try context.save()
//
//            // Reload the TableView to account for the new data
//            self.tableView.reloadData()
//        } catch {
//            print("Error saving context, \(error)")
//        }
//    }
    
//    func loadItems() {
//        // The "try? ..." turns the result of the method (the ...) into an optional -> from there we can use "optional binding" to unwrap the optional safely
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            // Use decoder instead of UserDefaults
//            let decoder = PropertyListDecoder()
//
//            do {
//                // Need to specify the data type as the first param of .decode()
//                    // Our data type is an array of Item objects -> to refer to this type (array of Items), we need to use ".self" after the Item array statement ( [Item] )
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
//    }
    
    // *-- INTRODUCTION OF Core Data --*
    // The parameter = ... -> sets a default value for the parameter -> this default value is used if no param/data is passed in for said parameter
    // "with" = external parameter name, "request" = internal parameter name
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        // This is a general request that asks for all data back
//        //let request: NSFetchRequest<Item> = Item.fetchRequest()   // * Specify the Entity for the NSFetchRequest
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        // Create a compound predicate so that we can insert both our category-predicate query & the incoming parameter predicate
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, categoryPredicate])
////
////        request.predicate = compoundPredicate
//        // Optional Binding -> if "predicate" parameter is not nil (which it has a default value of nil)
//            // additionalPredicate becomes the unwrapped variable if the "predicate" variable is indeed not nil
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            // context.fetch(...) returns a NSFetchRequestResult, which we know to be an array of Item objects/entities that is stored in our persistent container
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }
//
//        // Reload the TableView to reflect the new data
//        tableView.reloadData()
//
//    }
    
    // **-- INTRODUCTION OF Realm --**
    func loadItems() {
        // Get the items from the selected category relationship & sort by "title" in ascending order
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }

}

// MARK: - SearchBar Delegate Methods
// Create an "extension" of the TodoListViewController -> allows us to have a seperate area for code/functionality
    // This extensions "extends" our base ViewController and gives it extra functionality to handle UISearchBar elements
// Add UISearchBarDelegate to allow this ViewController to be the delegate for the UISearchBar element
extension TodoListViewController: UISearchBarDelegate {

    // Tells the delegate that the "Search" button was clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        // Specify our filter/query
//            // %@ represents our arguments
//            // "CONTAINS" -> looking for the title that contains the searchBar text -> not doing an exact matching ( == )
//            // [cd] makes the search (c)ase incensitive and (d)iacritic incensitive
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        // Set the request's sortDescriptor -> notice the variable wants an array
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
        
        
        // **-- INTRODUCTION OF Realm --**
        
        // Set our todoItems collection = a filtered and sorted version of the todoItems collection (i.e., apply a filter and sort logic)
            // Specify our filter/query AND our sorting logic
                // %@ represents our arguments
                // "CONTAINS" -> looking for the title that contains the searchBar text -> not doing an exact matching ( == )
                // [cd] makes the search (c)ase incensitive and (d)iacritic incensitive
            // Sort by the "title" in ascending order
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

    }

    // Delegate method that is fired whenever text in the searchBar changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            // Call loadItems(...) without a param to use the parameter's default value
            loadItems()

            // DispatchQueue is the "manager" that assigns tasks to the various threads ***********
                // DispathQueue.main -> grab the main thread
                // DispatchQueue.main.async -> run an async. task on the main thread
            DispatchQueue.main.async {
                // Makes the searchBar remove its "status" as the first responder in its window -> should no longer be the element that is currently selected
                searchBar.resignFirstResponder()
            }

        }
    }

}

