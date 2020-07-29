//
//  SecondViewController.swift
//  SeagueProtocolPractice
//
//  Created by Ranajit Chandra on 18/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit

protocol ExchangeValue {
    func getValueFromSecondViewController(data: String)
}

class SecondViewController: UIViewController {

    var data:String = ""
    var delegate:ExchangeValue?
    @IBOutlet var label2: UILabel!
    @IBOutlet var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label2.text = data
    }

    @IBAction func buttonPressed2(_ sender: UIButton) {
        delegate?.getValueFromSecondViewController(data: textField2.text!)
        dismiss(animated: true, completion: nil)
    }
    
}
