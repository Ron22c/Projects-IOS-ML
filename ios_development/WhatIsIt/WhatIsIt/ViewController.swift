//
//  ViewController.swift
//  WhatIsIt
//
//  Created by Ranajit Chandra on 23/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageUser: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageUser.image = userImage
            guard let ciImage = CIImage(image: userImage) else {
                fatalError("Could not convert to CIImage")
            }
            detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("inception model did not found")
        }
        
        let request = VNCoreMLRequest(model: model) {
            (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to get response from coreML")
            }
            if let item = results.first {
                print(item.identifier)
                self.navigationItem.title = item.identifier
//                if item.identifier.contains("hotdog") {
//                    self.navigationItem.title = "HotDog!!"
//                } else {
//                    self.navigationItem.title = "Not A HotDog!!"
//                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

