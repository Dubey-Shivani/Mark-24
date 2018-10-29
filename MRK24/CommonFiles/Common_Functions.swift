//
//  Common_Functions.swift
//  Cab Booking
//
//  Created by Solutionner Software on 06/07/17.
//  Copyright © 2018 Solutionner Software. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

func menuButton(imageName : String) -> UIButton {
    let menuBtn = UIButton(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(30), height: CGFloat(30)))
    let newImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
//    newImage.contentMode = .scaleAspectFit
//    newImage.translatesAutoresizingMaskIntoConstraints = false
    menuBtn.imageView?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    menuBtn.setImage(newImage, for: .normal)
//    menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
    menuBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    
    return menuBtn
}

func getDeviceToken() -> String {
    //check if DCDevice is available (iOS 11)
    
    let uuid = UIDevice.current.identifierForVendor!.uuidString
    print("uuid: \(uuid)")
    return uuid
}

func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

func isValidEmailID(txtEmail : String) -> Bool {
    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: txtEmail) {
            return true
        }
        else{
            return false
        }
    }

func isValidName(txtName: String) -> Bool {
    
    let firstNameRegex = "[a-zA-z]+([ '-][a-zA-Z]+)*$"
    let firstNameTest = NSPredicate(format: "SELF MATCHES %@", firstNameRegex)
    
    let result = firstNameTest.evaluate(with: txtName)
      if result == false {
        return false
    }
    
    return result

}

func isValidMobileNo(mobileNo : String) -> Bool {
  
    let noRegex = "[0-9]{6,14}$"
    let noTest = NSPredicate(format: "SELF MATCHES %@", noRegex)
    
    let result = noTest.evaluate(with: mobileNo)

    
    
    if result == false {
     
        return false
    }
    return result
    
}
func isValidOTP(OTP : String) -> Bool {
    
    let noRegex = "[0-9]{6,14}$"
    let noTest = NSPredicate(format: "SELF MATCHES %@", noRegex)
    
    let result = noTest.evaluate(with: OTP)
    
    if result == false {
        
        return false
    }
    return result
    
}

func dateToString(_ date:Foundation.Date) -> String {
    let formatter = Foundation.DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy hh:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    let dateString = formatter.string(from: Foundation.Date())
    return dateString
}

func alertWithMessage(title : String , message : String ,  vc : Any)  {
    
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    (vc as? UIViewController)?.present(alert, animated: true, completion: nil)
    
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(self)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}



