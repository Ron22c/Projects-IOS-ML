//
//  SelfDrivengCar.swift
//  CodingPractice
//
//  Created by Ranajit Chandra on 16/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import Foundation

class SelfDrivingCar:Car {
    var destination:String?
    override func drive() {
        super.drive()
        if let userDist = destination {
            print("This is selfdriving " + userDist)
        }
    }
}
