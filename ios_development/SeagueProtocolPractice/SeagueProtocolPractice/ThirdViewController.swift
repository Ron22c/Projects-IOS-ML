//
//  ThirdViewController.swift
//  SeagueProtocolPractice
//
//  Created by Ranajit Chandra on 19/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol ThirdDataTransfer {
    func getDataFromFirst(data: String)
}

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var data = ""
    let dataArr:[String] = ["INR", "USD", "EURO"]
    var baseUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var delegate :ThirdDataTransfer?
    @IBOutlet var textLavel: UILabel!
    @IBOutlet var textFiels: UITextField!
    @IBOutlet var UipIcker: UIPickerView!
    @IBOutlet var priceData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLavel.text = data
        UipIcker.delegate = self
        UipIcker.dataSource = self
    }
    
    func getWeatherData(url: String) {
        let headers = [
               "x-ba-key": "NWZjODcxODRjN2E1NDZmNmE5MDhmM2JhNGI0OWNlOTI",
           ]
        Alamofire.request(url, method: .get, headers: headers).responseJSON{
            response in
            if response.result.isSuccess {
                let responseData: JSON = JSON(response.value!)
                self.parseJsonAndShow(data: responseData)
            } else {
                print("Error is: \(String(describing: response.result.error))")
            }
        }
    }
    
    func parseJsonAndShow(data: JSON) {
        print(data)
        let price = String(data["averages"]["day"].intValue)
        self.priceData.text = price
    }
    
    @IBAction func buttonThree(_ sender: UIButton) {
        let textData = self.textFiels.text
        delegate?.getDataFromFirst(data: textData!)
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let finalUrl = baseUrl+dataArr[row]
        self.getWeatherData(url: finalUrl)
        print("selected Row: \(row)")
    }
}
