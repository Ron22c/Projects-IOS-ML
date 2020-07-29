//
//  ViewController.swift
//  Swift-Practice
//
//  Created by Ranajit Chandra on 16/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let squre = UIView(frame: CGRect(x: self.view.frame.width/2 - 100/2, y: self.view.frame.height/2 - 100/2, width: 100, height: 100))
        squre.backgroundColor = UIColor.red
        self.view.addSubview(squre)
    }
}
