//
//  CurrencyController.swift
//  ProjectM
//
//  Created by Ranajit Chandra on 06/03/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CurrencyController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickValue: UIPickerView!
    
    let URL = "https://www."
    let valueArr: [String] = ["first", "second", "third"]
    
    @IBOutlet weak var currency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickValue.delegate = self
        
    }
    
    func fetchData(data: String) {
        Alamofire.request(URL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.valueArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.valueArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = self.valueArr[row]
        
    }
}
