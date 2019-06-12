//
//  ViewController.swift
//  viewcontroller segues
//
//  Created by Matt on 6/12/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        
        // When the button is pressed, handle the segue
            // Use the identifier we gave the segue
            // The sender is the current ViewController (i.e., self)
        performSegue(withIdentifier: "goToSecondScreen", sender: self)
        
    }
    
    // Handle the passing over of data from one ViewController to another
    /*
        - Every ViewController has a prepare(...) method
            - Performs the actions that should happen just before a segue transition
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen" {
            // Get a ref. to the second ViewController -> get the destination ViewController from the segue & then cast it as "SecondViewController" that was made earlier
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.textPassedOver = textField.text
            
        }
    }
    
}

