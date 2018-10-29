//
//  CurrentUser.swift
//  Instakilo
//
//  Created by TEST on 4/6/18.
//  Copyright © 2018 TEST. All rights reserved.
//

import Foundation
import UIKit

let kCurrentUser = "User"
class CurrentUser: NSObject, NSCoding {
	struct Static {
		static var instance: CurrentUser?
	}
	
	class var sharedInstance: CurrentUser {
		if Static.instance == nil
		{
			Static.instance = CurrentUser()
		}
		
		return Static.instance!
	}
	
	func dispose() {
		CurrentUser.Static.instance = nil
        UserDefaults.standard.set(value: nil, key: kCurrentUser, synchronize: true)

		print("Disposed Singleton instance")
	}
	
	private override init() {}
	
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
    
        self.id = aDecoder.decodeObject(forKey: "id") as? String
        self.username = aDecoder.decodeObject(forKey: "username") as? String
        self.first_name = aDecoder.decodeObject(forKey: "first_name") as? String
        self.last_name = aDecoder.decodeObject(forKey: "last_name") as? String
        self.email_id = aDecoder.decodeObject(forKey: "email_id") as? String
        self.address = aDecoder.decodeObject(forKey: "address") as? String
        self.city = aDecoder.decodeObject(forKey: "city") as? String
        self.state = aDecoder.decodeObject(forKey: "state") as? String
        self.country = aDecoder.decodeObject(forKey: "country") as? String
        self.phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
        self.devicetoken = aDecoder.decodeObject(forKey: "devicetoken") as? String
        
    }
    func encode(with anEncoder: NSCoder) {
        if let id = id {
            anEncoder.encode(id, forKey: "id")
        }
        if let username = username {
            anEncoder.encode(username, forKey: "username")
        }
        if let first_name = first_name {
            anEncoder.encode(first_name, forKey: "first_name")
        }
        if let last_name = last_name {
            anEncoder.encode(last_name, forKey: "last_name")
        }
        if let email_id = email_id {
            anEncoder.encode(email_id, forKey: "email_id")
        }
        if let address = address {
            anEncoder.encode(address, forKey: "address")
        }
        if let city = city {
            anEncoder.encode(city, forKey: "city")
        }
        if let state = state {
            anEncoder.encode(state, forKey: "state")
        }
        if let country = country {
            anEncoder.encode(country, forKey: "username")
        }
        if let phone_number = phone_number {
            anEncoder.encode(phone_number, forKey: "phone_number")
        }
        if let password = password {
            anEncoder.encode(password, forKey: "password")
        }
        if let devicetoken = devicetoken {
            anEncoder.encode(devicetoken, forKey: "devicetoken")
        }
        
    }
    
    
    
    
    var id:String?
    var username:String?
    var first_name:String?
    var last_name:String?
    var email_id:String?
    var address:String?
    var city:String?
    var state:String?
    var country:String?
    var phone_number:String?
    var password:String?
    var devicetoken:String?
    var createdTime:Date?
    var profileImage:UIImage?
	
}


