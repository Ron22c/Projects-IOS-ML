//
//  main.swift
//  CodingPractice
//
//  Created by Ranajit Chandra on 16/02/20.
//  Copyright © 2020 Ranajit Chandra. All rights reserved.
//

import Foundation


let myCar = Car()
print(myCar.color)
print(myCar.numberOfSeats)
print(myCar.typeOfCar)

myCar.drive()

let SelfCar = SelfDrivingCar()
SelfCar.destination = "1 hacker way"
SelfCar.drive()

var error501 = (errorCode: 501, description: "Not Implemented")
print(error501.errorCode)

let addition = {
    (val1: Int, val2:Int) -> Int in
    let i = val2/23
    let j = val1/3
    return i+j
}

func addFunc(val1:Int, val2:Int) -> Int {
    return val2+val2+val1
}

let division = {
    (one:Int, two:Int) ->Int in
    return one/two
}

print(division(12,34))
print(addFunc(val1: 12, val2: 13))


struct StructureOne {
    var one :Int
    var two :Int
    var three :Int
    
    init (one :Int, two:Int, three:Int) {
        self.one = one
        self.three = three
        self.two = two
    }
    
    func functionStruc() {
        print("this is a func")
    }
}

func makeInc(n: Int) -> (Int) -> Int {
    func inc(x: Int) -> Int {
        return n + x
    }
    return inc
}



let a = makeInc(n: 24)
print(a.self)
print(a(34))

let myStruct = StructureOne(one:12,two:34,three:56)
myStruct.functionStruc()
