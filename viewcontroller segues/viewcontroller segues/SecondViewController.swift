//
//  SecondViewController.swift
//  viewcontroller segues
//
//  Created by Matt on 6/12/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var textPassedOver: String?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = textPassedOver
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
