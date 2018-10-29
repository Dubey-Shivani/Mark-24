//
//  CornerRadius.swift
//  Ardhi
//
//  Created by Lokesh  yadav on 9/22/16.
//  Copyright © 2016 Solutions 4 Mobility. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable var buttonCorner: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}



extension UILabel {
    @IBInspectable var labelCorner: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


extension UIView {
    @IBInspectable var ViewCorner: CGFloat {
        get {
            return layer.cornerRadius
            
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
            
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var viewBordercolor: UIColor {
        get {
             return UIColor(cgColor:layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    
   
    
   
}

