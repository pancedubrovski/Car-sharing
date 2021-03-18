//
//  Location.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 12.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import Foundation
import MapKit


class LocationCar : Codable {
    
   
    var longitude : Double
    var latitude : Double
    var city:String
    var country:String
    
    
    
    init(longitude:Double,latitude:Double,city:String,country:String){
        self.longitude = longitude
        self.latitude = latitude
        self.city = city
        self.country = country
    }
}
