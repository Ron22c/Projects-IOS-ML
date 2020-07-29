//
//  WeatherViewController.swift
//  weather-message
//
//  Created by Ranajit Chandra on 24/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {

    let WEATHER_URL = "http://openweathermap.org/data/2.5/weather"
    let APP_ID = "b6907d289e10d714a6e88b30761fae22"
    let locationManager = CLLocationManager()
    let locationArr :[String] = ["Bengaluru", "Kolkata", "delhi", "new york"]
    
    @IBOutlet var temparatureLabel: UILabel!
    @IBOutlet var cityPickerView: UIPickerView!
    @IBOutlet var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getWeatherData(url: String, params: [String: String]){
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                let res:JSON = JSON(response.value!)
                self.deserializeAndShow(data: res)
                
            }
        }
    }
    
    func deserializeAndShow(data:JSON) {
        print(data)
        if let city = data["name"].string {
            let temp = data["main"]["temp"].stringValue
            temparatureLabel.text = temp
            cityLabel.text = city
        }
    }
    
    @IBAction func discussionButton(_ sender: UIButton) {
        performSegue(withIdentifier: "community", sender: self)
    }
    
    @IBAction func signoutWeatherVC(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Failed to sign out")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(locationArr[row])
        let params :[String:String] = ["q":locationArr[row], "appid":APP_ID]
        self.getWeatherData(url: WEATHER_URL, params: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("inside this")
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let params : [String: String] = ["lat": String(latitude), "lon": String(longitude), "appid": APP_ID]
            getWeatherData(url: WEATHER_URL, params: params)
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
