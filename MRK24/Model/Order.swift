//
//  OrderHistoryItem.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/24/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.


import Foundation
struct Order {
    var orderID : String?
    var product : String?
    var issue : String?
    var submitted : String?
    var status : String?
    var orderDate : String?
    var signature : UIImage?
    var signatureUrl : String?
    var createdAt :String?
    var title: String?
    var uid :String?
    var updatedDate :String?
    var imagesArray : Array<String> = []
    var user : CurrentUser?
    
}


enum ProductType : String {
    case Desktop = "DESKTOP"
    case Laptop = "LAPTOP"
    case Server = "SERVER"
    case Mobile = "MOBILE"
    case None = "NONE"

    static var Products = [Desktop, Laptop, Server,Mobile]
}

enum OrderStatus : String {
    case InProgress = "Processing"
    case Completed = "Complete"
    case None = "NONE"

    
    static var status = [InProgress, Completed]
}

