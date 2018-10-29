//
//  Customer.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/19/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import Foundation


enum CustomerReg : String {
    case username = "User Name"
    case firstname = "First Name"
    case lastname = "Last Name"
    case email_id = "Email id"
    case address = "Address"
    case phone = "Phone No"
    case city = "City"
    case state = "State"
    case country = "Country"
    case password = "Password"
    case reenter = "Re-enter"

    static let customers = [username, firstname,lastname, email_id, address, phone, city, state, country, password, reenter]
}

enum CustomerEdit : String {
    case id = "id"
    case username = "User Name"
    case firstname = "First Name"
    case lastname = "Last Name"
    case email_id = "Email id"
    case address = "Address"
    case city = "City"
    case state = "State"
    case country = "Country"
    
    static let customersEdit = [username, firstname,lastname, email_id, address, city, state, country]
}

struct Customer {
    var id:String
    var username:String
    var first_name:String
    var last_name:String
    var email_id:String
    var address:String
    var city:String
    var state:String
    var country:String
    var phone_number:String
    var password:String
    var devicetoken:String
    var createdTime:Date

}
    

