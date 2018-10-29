//
//  FTMenuItem.swift
//  Ardhi
//
//  Created by Alex Zdorovets on 9/21/15.
//  Copyright (c) 2015 Solutions 4 Mobility. All rights reserved.
//

import UIKit

class FTSettingMenuitem: NSObject {
    var title : String
    var segueIdentifier : String
    
    
    init(title:String, seque: String) {
        self.title = title
        self.segueIdentifier = seque
    }
    
    
    class var plistName : String {
        get {
            return "SettingMenu"
        }
    }
    
    class var menuItems : Array<FTSettingMenuitem> {
        get {
            var items : Array<FTSettingMenuitem> = []
            if let path = Bundle.main.path(forResource: self.plistName, ofType: "plist") {
                guard let nsArray = NSArray(contentsOfFile: path) else {
                    return items
                }
                
                for item in nsArray {
                    if let value = item as? [String : String] {
                        items.append(FTSettingMenuitem(title: value["title"]!, seque: value["segueIdentifier"]!))
                        
                    }
                }
                
            }
            return items
        }
    }
}

