//
//  ViewController.swift
//  ProjectM
//
//  Created by Ranajit Chandra on 06/03/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func weatherButton(_ sender: UIButton) {
        performSegue(withIdentifier: "weather", sender: self)
    }
    
    @IBAction func currencyButton(_ sender: UIButton) {
        performSegue(withIdentifier: "currency", sender: self)
    }
    
    @IBAction func imageDetectorButton(_ sender: UIButton) {
        performSegue(withIdentifier: "imageDetector", sender: self)
    }
}

