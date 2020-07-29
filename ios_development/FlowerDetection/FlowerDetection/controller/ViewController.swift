//
//  ViewController.swift
//  FlowerDetection
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DetailPageDelegate {
    
    let BASE_URL = "https://en.wikipedia.org/w/api.php"

    @IBOutlet var flowerLabel: UILabel!
    @IBOutlet var flowerImage: UIImageView!
    var imagetosegue:UIImage!
    let imagePicker = UIImagePickerController()
    var data:JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            flowerImage.image = image
            imagetosegue = image
            guard let ciImage = CIImage(image: image) else {
                fatalError("Failed to convert UiImage to CIImage")
            }
            detectFlower(ciImage: ciImage)
        }
        imagePicker.dismiss(animated: true) {
            self.performSegue(withIdentifier: "detailPage", sender: self)
        }
        
    }
    
    func detectFlower(ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Unable to Initiate model")
        }
        
        let request = VNCoreMLRequest(model: model) {
            (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else{
                fatalError("failed to get response")
            }
            print(results)
            if let item = results.first {
                self.flowerLabel.text = item.identifier
                
                let parameters : [String:String] = [
                "format" : "json",
                "action" : "query",
                "prop" : "extracts|pageimages",
                "exintro" : "",
                "explaintext" : "",
                "titles" : item.identifier,
                "indexpageids" : "",
                "redirects" : "1",
                "pithumbsize": "500"
                ]

                self.getWikiData(params: parameters)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    func getWikiData(params: [String:String]) {
        Alamofire.request(BASE_URL, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                let res:JSON = JSON(response.value!)
                self.parseValue(value: res)
            } else {
                print("Failed to receive Data")
            }
        }
    }
    
    func parseValue(value: JSON) {
        self.data = value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let object = segue.destination as? DetailsViewController
        object?.data = self.data
        object?.delegate = self
    }
    
    func sendValueJSON() {
        print("successFul")
    }
}

