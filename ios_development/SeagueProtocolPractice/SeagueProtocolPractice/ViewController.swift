//
//  ViewController.swift
//  SeagueProtocolPractice
//
//  Created by Ranajit Chandra on 18/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, ExchangeValue, ThirdDataTransfer, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var textLabel1: UILabel!
    @IBOutlet var textLabel2: UILabel!
    @IBOutlet var textField1: UITextField!
    @IBOutlet var pickerView: UIPickerView!

    var dataReturnedBack:String = ""
    let URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let pickerViewData:[String] = ["INR", "USD", "EURO"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }

    @IBAction func buttonPressed1(_ sender: UIButton) {
        performSegue(withIdentifier: "ChangeView", sender: self)
    }
    @IBAction func buttonPressed2(_ sender: UIButton) {
        performSegue(withIdentifier: "thirdConnection", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeView" {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.data = textField1.text!
            secondViewController.delegate = self
        } else if segue.identifier == "thirdConnection" {
            let thirdViewController = segue.destination as! ThirdViewController
            thirdViewController.data = textField1.text!
            thirdViewController.delegate = self
        }
    }
    
    func getBitCoidData(url: String) {
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            if response.result.error == nil {
                let responseData: JSON = JSON(response.value!)
                self.deserializeJsonData(data: responseData)
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    func deserializeJsonData(data: JSON) {
        print(data)
        let price = data["averages"]["month"].stringValue
        print(price)
        self.textLabel1.text = price
    }
    
    func getValueFromSecondViewController(data: String) {
        textLabel1.text = data
    }
    
    func getDataFromFirst(data: String) {
        textLabel2.text = data
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let finalUrl = URL+pickerViewData[row]
        self.getBitCoidData(url: finalUrl)
        print(finalUrl)
    }
}

