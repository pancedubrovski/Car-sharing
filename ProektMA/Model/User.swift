//
//  User.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 29.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import Foundation


struct User : Codable {
    var firstName : String
    var lastName : String
    var email : String
    var phone : String
    var country : String
    
    init(email:String,firstName:String,lastName:String, phone:String, country:String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.country = country
    }
    init(firstName:String,lastName:String,phone:String){
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = ""
        self.country = ""
    }
    
}
