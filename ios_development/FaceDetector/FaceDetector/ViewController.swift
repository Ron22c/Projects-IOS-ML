//
//  ViewController.swift
//  FaceDetector
//
//  Created by Ranajit Chandra on 26/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let facerecognizerOptions = VisionFaceDetectorOptions()
    lazy var vision = Vision.vision()
    var faceDetector:VisionFaceDetector?
    let imagepicker = UIImagePickerController()
    
    @IBOutlet weak var dataObserved: UILabel!
    @IBOutlet weak var imageClicked: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facerecognizerOptions.performanceMode = .fast
        facerecognizerOptions.landmarkMode = .all
        facerecognizerOptions.classificationMode = .all
        
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing = true
        
        self.faceDetector = vision.faceDetector(options: facerecognizerOptions)
    }


    @IBAction func clickButton(_ sender: UIButton) {
        present(imagepicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageClicked.image = capturedImage
            let visionImage = VisionImage(image: capturedImage)
            detectFaces(vsnImage: visionImage)
        }
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    func detectFaces(vsnImage: VisionImage) {
        faceDetector?.process(vsnImage) {
            faceData, error in
            if error != nil {
                print("Faied")
                print(error!)
            } else {
                print(faceData!)
                for face in faceData! {
                  let frame = face.frame
                  if face.hasHeadEulerAngleY {
                    let rotY = face.headEulerAngleY
                    print(rotY)
                  }
                  if face.hasHeadEulerAngleZ {
                    let rotZ = face.headEulerAngleZ
                    print(rotZ)
                  }
                  if let leftEye = face.landmark(ofType: .leftEye) {
                    let leftEyePosition = leftEye.position
                    print(leftEyePosition)
                    }
                  if let leftEyeContour = face.contour(ofType: .leftEye) {
                    let leftEyePoints = leftEyeContour.points
                    print(leftEyePoints)
                    }
                  if let upperLipBottomContour = face.contour(ofType: .upperLipBottom) {
                    let upperLipBottomPoints = upperLipBottomContour.points
                    print(upperLipBottomPoints)
                    }
                  if face.hasSmilingProbability {
                    let smileProb = face.smilingProbability
                    print(smileProb)
                    }
                  if face.hasRightEyeOpenProbability {
                    let rightEyeOpenProb = face.rightEyeOpenProbability
                    print(rightEyeOpenProb)
                    }
                  if face.hasTrackingID {
                    let trackingId = face.trackingID
                    print(trackingId)
                  }
                }
            }
        }
    }
}

