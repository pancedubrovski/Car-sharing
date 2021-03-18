//
//  Noification.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 11.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import Foundation

class Notification {
    var user : User
    var car : CarView
    var total: Float
    var dateFrom : String
    var dateTo : String
    
   
    init(user:User,car:CarView,total:Float,
         dateFrom:String,dateTo : String){
        self.user = user
        self.car = car
        self.total = total
        self.dateTo = dateTo
        self.dateFrom = dateFrom
        
    }
}
