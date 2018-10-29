//
//  Extension.swift
//  Cab Booking
//
//  Created by Solutionner Software on 12/07/17.
//  Copyright © 2018 Solutionner Software. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableUITextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    func changeFontName()
    {
        self.font = UIFont(name: "SanFranciscoText-Semibold", size: 30)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 10);
        
    }
    
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        
        // print(textRect)
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        
    }
    
    public func isEmpty() -> Bool {
    
    return ((self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! > 0)
       
    }
    public func isValidPhoneNumberCount() -> Bool {
        
        return (self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! >= 10
    }
    public func isValidOTP() -> Bool {
        
        return (self.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count)! >= 1
    }
    
    
}
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        
        self.layer.cornerRadius = self.layer.cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowOpacity = 18
        self.layer.shadowOffset = CGSize(width: -1, height: 0.5)
        self.layer.shadowRadius = 0.5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.masksToBounds = false
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = self.layer.cornerRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.masksToBounds = false
      
    }
    // OUTPUT 3
        func ViewdropShadow() {
            
            self.layer.masksToBounds = false
            self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
            self.layer.shadowRadius = 0.5
            self.layer.borderWidth = 1
            self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 8.0
            
        }
    
}
extension UIButton {
    
    /// Makes the ``imageView`` appear just to the right of the ``titleLabel``.
    func alignImageRight() {
        if let titleLabel = self.titleLabel, let imageView = self.imageView {
            // Force the label and image to resize.
            titleLabel.sizeToFit()
            imageView.sizeToFit()
            imageView.contentMode = .scaleAspectFit
            
            // Set the insets so that the title appears to the left and the image appears to the right.
            // Make the image appear slightly off the top/bottom edges of the button.
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -1 * imageView.frame.size.width,
                                                bottom: 0, right: imageView.frame.size.width)
            self.imageEdgeInsets = UIEdgeInsets(top: 4, left: titleLabel.frame.size.width,
                                                bottom: 4, right: -1 * titleLabel.frame.size.width)
        }
    }
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+hh:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-80, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.85)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.numberOfLines = 5
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
extension String {
    func isUppercased(at: Index) -> Bool {
        let range = at..<self.index(after: at)
        return self.rangeOfCharacter(from: .uppercaseLetters, options: [], range: range) != nil
    }
}

extension Character {
    var isUppercase: Bool {
        let str = String(self)
        return str.isUppercased(at: str.startIndex)
    }
}

extension Int
{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
extension Range
{
    var randomInt: Int
    {
        get
        {
            var offset = 0
            
            if (lowerBound as! Int) < 0   // allow negative ranges
            {
                offset = abs(lowerBound as! Int)
            }
            
            let mini = UInt32(lowerBound as! Int + offset)
            let maxi = UInt32(upperBound   as! Int + offset)
            
            return Int(mini + arc4random_uniform(maxi - mini)) - offset
        }
    }
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: monday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: monday)
    }
    var startOfPastWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: monday)
    }
    var endOfPastWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -6, to: monday)
    }
    var startOfPastToPastWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -7, to: monday)
    }
    var endOfPastToPastWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let monday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: -14, to: monday)
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
    
    func asString(format:String) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func getDates(forLastNDays nDays: Int) -> [String] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        
        var arrDates = [String]()
        
        for _ in 1 ... nDays {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        print(arrDates)
        return arrDates
    }
}
internal extension DateComponents {
    mutating func to12am() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
    
    mutating func to12pm(){
        self.hour = 23
        self.minute = 59
        self.second = 59
    }
}
extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeAColl() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}
extension Date {
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}


extension UITextField{
     var placeHolderTextColor: UIColor? {
        get {
            return self.placeHolderTextColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
extension UserDefaults {
    
    //MARK: - Class
    
    public class func get(key:String) -> Any? {
        return UserDefaults.standard.get(key: key)
    }
    
    public class func set(value:Any?, key:String, synchronize:Bool = true) {
        UserDefaults.standard.set(value: value, key: key, synchronize: synchronize)
    }
    
    //MARK: - Instance
    
    public func get(key:String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    public func set(value: Any?, key: String, synchronize: Bool = true) {
        self.setValue(value, forKey: key)
        if synchronize {
            self.synchronize()
        }
    }
    
}



