//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Matt on 6/19/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    // Create an empty array of Category objects/entities
    var categoryArray = [Category]()
    
    // Context for our running app
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load categories from persistent storage
        loadCategories()
        
    }
    
    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the # of cells we want
        return categoryArray.count
    }
    
    // This gets run for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get reference to the cell(s) within the TableView by their "Reuse Identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        // Set the body/text of the cell to the String at the corresponding index in the itemArray
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    // ----------
    
    // MARK: - TableView Delegate Methods
    
    // Function/Event that gets called when a cell within the TableView is "clicked" on
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger the segue to the specific "items" of that category
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // Function/Event that gets called right before we perform a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Cast the segue destination's ViewController as a "TodoListViewController" as we know that is where the segue is going
        let destinationVC = segue.destination as! TodoListViewController
        
        // Get the category that corresponds to the selected cell
            // The indexPath that identifies the current row that is selected -> returns an optional if nothing is selected
            // Use "if let".
        if let indexPath = tableView.indexPathForSelectedRow {
            // If the result of the optional is not nil, run the code
            destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
    }
    
    // ----------
    
    // MARK: - Data Manipulation Methods
    
    func saveCategories() {
        do {
            // Try to save to our persistent storage
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        // Reload the TableView to account for the new data
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        
        // Reload the TableView to reflect the new data
        tableView.reloadData()
        
    }
    
    // ----------
    
    // MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Want a UIAlert to show with a text field so that the user can write in their new category
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        // Create a local textField variable so that we can get the alert TextField from the closure
        var textField = UITextField()
        
        // Add a TextField to the alert
        alert.addTextField { (alertTextField) in
            // The placeholder text for the TextField
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What will happen once the user clicks the "Add Category" button on the UI Alert
            
            // Check to make sure there is actually content inside of the TextField
            // If the user simply hits "Add Category" w/o writing anything, the TextField.text length is 0
            if(textField.text!.count != 0) {
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                
                self.categoryArray.append(newCategory)
                
                // Save the array to reflect updated data && reload the TableView (inside the method)
                self.saveCategories()
                
            }
            
        }
        
        // Add the action to the alert
        alert.addAction(action)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
    }
    
    // ----------
    
}
