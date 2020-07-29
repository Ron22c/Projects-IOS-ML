//
//  Cars.swift
//  CodingPractice
//
//  Created by Ranajit Chandra on 16/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import Foundation

enum CarType {
    case HatchBack
    case sedan
    case coupe
}

class Car {
    var color = "Black"
    var numberOfSeats:Int = 5
    var typeOfCar:CarType = .HatchBack
    
    init() {
    }
    
    init(color: String) {
        self.color = color
    }
    
    func drive() {
        print("The car is moving.....")
    }
}
