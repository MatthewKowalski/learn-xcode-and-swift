//
//  ViewController.swift
//  Todoey
//
//  Created by Matt on 6/17/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //var itemArray = ["Eat", "Code", "Sleep"]
    
    // Empty array of Item objects
    var itemArray = [Item]()
    
    // Create UserDefaults object
        // UserDefaults -> where you store key-value pairs persistently across launches of our app
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load in the array currently saved in our storage
            // ** Use "if let" to make sure that this array exists and is not nil -> if it DOES exist, then set itemArray = items (the array we pulled from storage) **
//        if let items = defaults.array(forKey: "todoListArray") as? [String] {
//            itemArray = items
//        }
        
        let newItem = Item(title: "Sample", done: false)
        itemArray.append(newItem)
        
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
        
        // Set the "done" variable to the opposite of what it is now
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        // NOTE: No longer need this as we handle it in the above method
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = (cell?.accessoryType == .checkmark) ? .none : .checkmark

        // Reload the TableView to account for new data
        tableView.reloadData()
        
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
                self.itemArray.append(Item(title: textField.text!, done: false))
                
                // Save the updated array to our UserDefaults -> key-value pair
                self.defaults.set(self.itemArray, forKey: "todoListArray")
                
            }
            
            // Reload the TableView to account for the new data
            self.tableView.reloadData()
            
        }
        
        // Add the action to the alert
        alert.addAction(action)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
        
    }
    

}

