//
//  ViewController.swift
//  Todoey
//
//  Created by Matt on 6/17/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    //var itemArray = ["Eat", "Code", "Sleep"]
    
    // Empty array of Item objects
    var itemArray = [Item]()
    
    // Path to Documents directory in the applicaton's directory -> the path is specified for our custom "Items.plist" file (UserDefaults)
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // *-- INTRODUCTION OF Core Data --*
    // "shared" returns the singleton app instance -> refers to our live application (when the app is running) -> we then cast is as our AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Create UserDefaults object
        // UserDefaults -> where you store key-value pairs persistently across launches of our app
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
        // *-- CoreData sqllite file in this path, but /Library/Application Support/ instead of /Documents/ -> open .sqlite file with a SQLite program --*
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // Load in the array currently saved in our storage
            // ** Use "if let" to make sure that this array exists and is not nil -> if it DOES exist, then set itemArray = items (the array we pulled from storage) **
//        if let items = defaults.array(forKey: "todoListArray") as? [Item] {
//            itemArray = items
//        }
        
        // Get items from storage and load them
        loadItems()
        
    }
    
    // MARK:- TableView Datasource Methods
    // Essentially required to show the cells in the TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the # of cells we want
        return itemArray.count
    }
    
    // This gets run for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get reference to the cell(s) within the TableView by their "Reuse Identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        // Set the body/text of the cell to the String at the corresponding index in the itemArray
        cell.textLabel?.text = item.title
        
        // Set the accessory marker depending on the value of the "done" boolean for the Item object(s)
        cell.accessoryType = (item.done) ? .checkmark : .none
        
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        // NOTE: No longer need this as we handle it in the above method
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = (cell?.accessoryType == .checkmark) ? .none : .checkmark

        // Save the array to reflect updated data && reload the TableView (inside the method)
        saveItems()
        
        // Make it so that the selected row/cell doesn't stay highlighted upon a click
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK:- Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Want a UIAlert to show with a text field so that the user can write in their new item
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Create a local textField variable so that we can get the alert TextField from the closure
        var textField = UITextField()
        
        // Add a TextField to the alert
        alert.addTextField { (alertTextField) in
            // The placeholder text for the TextField
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the "Add Item" button on the UI Alert
            
            // Check to make sure there is actually content inside of the TextField
                // If the user simply hits "Add Item" w/o writing anything, the TextField.text length is 0
            if(textField.text!.count != 0) {
                
                //self.itemArray.append(textField.text!)
                //self.itemArray.append(Item(title: textField.text!, done: false))
                
                // *-- INTRODUCTION OF Core Data --*
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                self.itemArray.append(newItem)
                
                // Save the updated array to our UserDefaults -> key-value pair
                // ** NOTE: UserDefaults rejects this & throws an error as we are trying to set an array of custom objects to the plist of UserDefaults -> UserDefaults doesn't handle custom objects like this & throws the error **
                //self.defaults.set(self.itemArray, forKey: "todoListArray")
                
                // Save the array to reflect updated data && reload the TableView (inside the method)
                self.saveItems()
                
            }
            
        }
        
        // Add the action to the alert
        alert.addAction(action)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- Model Manipulation Methods
    
    func saveItems() {
        // Use encoder instead of UserDefaults due to the above issue we face/discussed
//        let encoder = PropertyListEncoder()
//
//        do {
//            let data = try encoder.encode(itemArray)
//
//            // Write the data to our data file path
//            try data.write(to: dataFilePath!)
//
//        } catch {
//            print("Error encoding item array, \(error)")
//        }
        
        // *-- INTRODUCTION OF Core Data --*
        do {
            // Try to save to our persistent storage
            try context.save()
            
            // Reload the TableView to account for the new data
            self.tableView.reloadData()
        } catch {
            print("Error saving context, \(error)")
        }
    }
    
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
    func loadItems() {
        // This is a general request that asks for all data back
        let request: NSFetchRequest<Item> = Item.fetchRequest()   // * Specify the Entity for the NSFetchRequest
        do {
            // context.fetch(...) returns a NSFetchRequestResult, which we know to be an array of Item objects/entities that is stored in our persistent container
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        
    }

}

