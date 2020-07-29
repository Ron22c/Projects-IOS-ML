//
//  ViewController.swift
//  WhatIsThat
//
//  Created by Ranajit Chandra on 24/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var capturedImage: UIImageView!
    @IBOutlet var detectedObject: UILabel!
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = false
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            capturedImage.image = image
            guard let ciImage = CIImage(image: image) else {
                fatalError("Unable to convert image to CIImage")
            }
            detect(image: ciImage)
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("unable to find core ML model")
        }
        
        let request = VNCoreMLRequest(model: model) {
            (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("failed to get result from coreML model")
            }
            print(result)
            if let object = result.first {
                self.detectedObject.text = object.identifier
            }
        }
        
        let handler = VNImageRequestHandler(ciImage:image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

