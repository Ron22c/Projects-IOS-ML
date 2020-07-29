//
//  WeatherController.swift
//  ProjectM
//
//  Created by Ranajit Chandra on 06/03/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherController: UIViewController,CLLocationManagerDelegate {
    let WEATHER_URL = "https://openweathermap.org/data/2.5/weather"
    let APP_ID = "b6907d289e10d714a6e88b30761fae22"
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityNameText: UITextField!
    @IBOutlet weak var temparature: UILabel!
    
    let locationMaager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationMaager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationMaager.delegate = self
        locationMaager.requestWhenInUseAuthorization()
        locationMaager.startUpdatingLocation()
    }
    
    func getLocationData(params: [String:String]) {
        Alamofire.request(WEATHER_URL, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                let data:JSON = JSON(response.value!)
                self.updateUI(data: data)
            }
        }
    }
    
    func updateUI(data: JSON) {
        if var temp:String = data["main"]["temp"].stringValue {
            let name = data["name"].stringValue
            self.cityName.text = name
            self.temparature.text = temp
        } else{
            self.cityName.text = "INTERNAL ERROR!!! YOU DID SOMETHING WRONG"
        }
        print(data)
    }
    
    @IBAction func getTemp(_ sender: UIButton) {
        let city = self.cityNameText.text
        let params: [String: String] = ["q": city!, "appid":APP_ID]
        getLocationData(params: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            let lattituede = location.coordinate.latitude
            let long = location.coordinate.longitude
            let params : [String: String] = ["lat": String(lattituede), "lon": String(long), "appid": APP_ID]
            getLocationData(params: params)
        }
    }
}
