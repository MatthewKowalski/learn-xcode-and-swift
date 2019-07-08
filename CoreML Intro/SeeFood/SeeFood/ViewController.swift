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
            
            // Convert the UIImage to a CIImage (CoreImage Image) -> allows us to use the CoreML & Vision frameworks
            guard let ciimage = CIImage(image: userPickedImg) else {
                fatalError("Error converting UIImage to CIImage.")
            }
            
            // Perform the image analysis
            detect(image: ciimage)
            
        }
        
        // Dismiss the ImagePicker
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    func detect(image: CIImage) {
        // Define our model
            // Need "try" as it will attempt the operation which may throw an error
            // If it succeeds, the result will be an Optional. Else, it will be nil
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {   // VNCoreMLModel comes from Vision & allows us to perform an image analysis request
            fatalError("Loading CoreML Model Failed.")
        }
        
        // Create Vision CoreML request
        let request = VNCoreMLRequest(model: model) { (vnRequest, error) in
            // Proccess the result of the request
                // Cast the results because it comes back as an array of Any -> [Any]
            guard let results = vnRequest.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            //print(results)    // Print the results -> the first result is the one with the highest confidence
            
            // Check the first result and see if it contains "hotdog" -> doing this as the app is based on the show Silicon Valley & the "SeeFood" app
            if let firstResult = results.first {
                self.navigationItem.title = (firstResult.identifier.contains("hotdog")) ? "Hotdog!" : "Not Hotdog!"
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            // Make the handler perform our request
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        // Present the ImagePickerController
        present(imagePicker, animated: true, completion: nil)
    }
    
}

