//
//  Car.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 6.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import Foundation


class Car {
    
    var brend:String
    var model : String
    var rent : Float
    var doors : String
    var consumption : String
    var speed : String
    var year : String
    
    
    init(brend:String,model:String,rent:Float,doors:String,consumption:String,
         speed:String ,year:String){
        self.brend = brend
        self.model = model
        self.rent = rent
        self.doors = doors
        self.consumption = consumption
        self.speed = speed
        self.year = year
    }
    
}
struct postCar  {
    var brend: String
    var carId: String
    var location : LocationCar
    var consumation : String
    var dataFrom : String
    var dataTo : String
    var imagesUrl: [String]
    var model:String
    var ownerId : String
    var price : Float
    var speed : String
    var year : String
    var passengers : String
}
class CarView {
 
    var imageUrl : String
    var brend : String
    var model : String
    var price : Float
    var passenges : String
    var consumption : String
    var speed : String
    var year: String
    


    init(imageUrl: String, model: String,brend:String, price:Float,passenges:String,consumption:String
        ,speed:String,year:String){
        self.imageUrl = imageUrl
        self.brend = brend
        self.model = model
        self.price = price
        self.passenges = passenges
        self.consumption = consumption
        self.speed = speed
        self.year = year
    }
    init(brend:String,model:String,year:String){
        self.brend = brend
        self.model = model
        self.year = year
        self.imageUrl = ""
        self.consumption = ""
        self.passenges = ""
        self.price = 0
        self.speed = ""
    }
}
