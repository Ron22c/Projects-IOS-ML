//
//  ImageDetector.swift
//  ProjectM
//
//  Created by Ranajit Chandra on 06/03/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ImageDetector: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let clickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.userImage.image = clickedImage
            guard let ciImage = CIImage(image: clickedImage) else {
                fatalError("Unable to conver image into CIImage")
            }
            self.detectImage(ciImage: ciImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func detectImage(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("unable to initialize the mlmodel")
        }
        
        let request = VNCoreMLRequest(model: model) {
            request, error in
            if error != nil {
                print(error!)
            } else {
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Unable to convert the result")
                }
                print(results)
                let res = results.first?.identifier
                self.imageLabel.text = res
            }
        }
        
        let handler = VNImageRequestHandler(ciImage:ciImage)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }

    }
    
    @IBAction func camera(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
}
