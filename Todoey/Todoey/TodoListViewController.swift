//
//  ViewController.swift
//  Todoey
//
//  Created by Matt on 6/17/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Eat", "Code", "Sleep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        
        // Set the body/text of the cell to the String at the corresponding index in the itemArray
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK:- TableView Delegate Methods
    
    // Function/Event that gets called when a cell within the TableView is "clicked" on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = (cell?.accessoryType == .checkmark) ? .none : .checkmark

        
        // Make it so that the selected row/cell doesn't stay highlighted upon a click
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

