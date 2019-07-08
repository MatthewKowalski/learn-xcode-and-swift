//
//  ViewController.swift
//  SeeFood
//
//  Created by Matt on 7/8/19.
//  Copyright © 2019 Matthew Kowalski. All rights reserved.
//

import UIKit
import CoreML
import Vision   // Helps us process images easier and allows us to use images that work with CoreML without having to write a lot more code

// We must specify access in info.plist for privacy reasons
    // Add property - "Privacy - Camera Usage..." -> specify the reason that we need access to the camera -> if we want users to use their camera
    // Add property - "Privacy - Photo Library Usage..." -> specify the reason that we need access to the camera -> if we want users to pick from their photo libraries

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate as self (this class - ViewController)
        imagePicker.delegate = self
        
        // Set properties
        imagePicker.sourceType = .camera    // From Docs: The type of picker interface to be displayed by the controller.
        imagePicker.allowsEditing = false   // From Docs: A Boolean value indicating whether the user is allowed to edit a selected still image or movie
        
    }
    
    // Tells the delegate that the user has "picked" an image -> i.e., they are done and we want to do something with what they have picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image that the user has selected
            // Get it from the "info" Dictionary by the specified key -> UIImagePickerController.InfoKey.originalImage
            // Because the data is of type Any, we need to cast it as a UIImage -> use if-let to handle if the casting results in nil
        if let userPickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Set the imageView to the image that they picked
            imageView.image = userPickedImg
        }
        
        // Dismiss the ImagePicker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // Present the ImagePickerController
        present(imagePicker, animated: true, completion: nil)
    }
    
}

