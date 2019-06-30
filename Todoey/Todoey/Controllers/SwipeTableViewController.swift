//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Matt on 6/30/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit
import SwipeCellKit

// A SuperClass for dealing with the SwipeCellKit Library / Delegate Methods
class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK:- TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get reference to the cell(s) within the TableView by their "Reuse Identifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell // Cast as SwipeTableViewCell to use SwipeCellKit library
        
        // Set cell delegate to this class so that we can use SwipeCellKit & handle actions here
        cell.delegate = self
        
        return cell
    }
    
    // ----------
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // Handle the action
            self.updateModel(at: indexPath)
        }
        
        // Action Appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        
        options.expansionStyle = .destructive   // This option removes the cell -> so we don't need to call tableView.reloadData() in the above delegate method
        
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
    }

}
