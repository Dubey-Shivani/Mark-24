//
//  APIHandler.swift
//  MRK24
//
//  Created by Lokesh  yadav on 10/26/18.
//  Copyright © 2018 Lokesh  yadav. All rights reserved.

import UIKit

let baseAPIUrl                  = "http://getmrk.com/mrk24.com/"
let RegistrationApi             =  "api_registration.php"
let LoginApi                    =  "api_login.php"
let ForgotApi                   =  "api_forgotpassword.php"
let ResetPasswordApi            =  "api_changepassword.php"
let RaiseRequestApi             =  "api_request.php"
let GetAllRequestApi            =  "api_getallrequest.php"
let EditProfileApi              =  "api_editprofile.php"

enum PossibleErrors : Error {
    
    case errorInResponse
    case emptyFile
    
}
class APIHandler: NSObject {
    
    
    let urlFactory = URLFactory()
    static var sharedInstance = APIHandler()
    private override init() {}
     var currentUser = CurrentUser.sharedInstance

    
    func registration(customer:Customer, completion: @escaping (_ registerInfo: String?, _ error: String?) -> Void) {
        let dic = ["firstname":customer.first_name,
                   "lastname":customer.last_name,
                   "emailid":customer.email_id,
                   "mobile_no":customer.phone_number,
                   "password":customer.password,
                   "address":customer.address,
                   "city":customer.city,
                   "state":customer.state,
                   "country":customer.country
                   ]
        print(dic)
        
        urlFactory.webServiceCall(methodName: RegistrationApi, with: dic) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            completion(info , nil)

                        }
                        return
                    }
                }
            }catch{
                print(error)

            }
           
        }
    }
    
    func profileUpdateRequest(customer:Customer, profileImage: UIImage?, completion: @escaping (_ updateInfo: String?, _ error: String?) -> Void) {
        
        let imageName = "\(String(describing: customer.first_name)).png"
        let resizedImage = profileImage!.jpeg(.low)
        let imageContent = resizedImage!.base64EncodedString()
        let dic = ["id":customer.id,
                   "username":customer.first_name,
                   "firstname":customer.first_name,
                   "lastname":customer.last_name,
                   "emailid":customer.email_id,
                   "address":customer.address,
                   "city":customer.city,
                   "state":customer.state,
                   "country":customer.country,
                   "profile_image_name ":imageName,
                   "profile_image_content ":imageContent
        ]
        print(dic)
        urlFactory.webServiceCall(methodName: EditProfileApi, with: dic) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            completion(info , nil)
                            
                        }
                        return
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    func login(userName email:String, withPassword pwd:String, completion: @escaping (_ customer: CurrentUser?, _ error: String?) -> Void) {
        let dic = ["emailid":email,
                   "password":pwd,
                   "device_token":getDeviceToken(),
                   "device_type":"2"]
        
        urlFactory.webServiceCall(methodName: LoginApi, with: dic) { (data, response, jsonError) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    let strongSelf = self
                    print(jsonResult)
                    
                    let errorCode = jsonResult["Code"] as! String
                    let info = jsonResult["status_message"] as! String
                    if Int(errorCode) != 200 {
                        completion(nil , info)
                        return
                    }else{
                        let datajson = jsonResult["data"]
                        self.initCustom(strongSelf: strongSelf, jsonResult: datajson as! [String : Any])
                        completion(strongSelf.currentUser, nil)
                        return
                    }
                   
                }
            }catch{
                print(error)
            }
        }
    }
    
    func initCustom(strongSelf:APIHandler, jsonResult:[String:Any])  {
        
        if let id = jsonResult["id"] as? String{
            strongSelf.currentUser.id = id
        }
        if let uname = jsonResult["username"] as? String{
            strongSelf.currentUser.username = uname
        }
        if let fname = jsonResult["firstname"] as? String{
            strongSelf.currentUser.first_name = fname
        }
        if let lname = jsonResult["lastname"] as? String{
            strongSelf.currentUser.last_name = lname
        }
        if let email = jsonResult["email"] as? String{
            strongSelf.currentUser.email_id = email
        }
        if let password = jsonResult["password"] as? String{
            strongSelf.currentUser.password = password
        }
        if let mobile = jsonResult["mobile"] as? String{
            strongSelf.currentUser.phone_number = mobile
        }
        if let address = jsonResult["address"] as? String{
            strongSelf.currentUser.address = address
        }
        if let state = jsonResult["state"] as? String{
            strongSelf.currentUser.state = state
        }
        if let city = jsonResult["city"] as? String{
            strongSelf.currentUser.city = city
        }
        if let country = jsonResult["country"] as? String{
            strongSelf.currentUser.country = country
        }
        if let devicetoken = jsonResult["device_token"] as? String{
            strongSelf.currentUser.devicetoken = devicetoken
        }
        if let profileImageData = jsonResult["profile_image_content"] as? String {
            let imageData : Data = Data(base64Encoded: profileImageData, options: .ignoreUnknownCharacters)!
            let image = UIImage(data: imageData)
            strongSelf.currentUser.profileImage = image
        }
        
    }

    
    func forgotPassword(userEmailId emailId:String, completion: @escaping (_ forgotInfo: String?, _ error: String?) -> Void) {
        let dic = ["email":emailId]
        urlFactory.webServiceCall(methodName: ForgotApi, with: dic) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            completion(info , nil)
                            
                        }
                        return
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    func resetPassword(UserEmailId emailId:String, withPassword pwd:String, completion: @escaping (_ resetInfo: String?, _ error: String?) -> Void) {
        let dic = ["email":emailId,
                   "password":pwd]
        print(dic)
        urlFactory.webServiceCall(methodName: ResetPasswordApi, with: dic) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            completion(info , nil)
                        }
                        return
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
   
    
    func raiserRequest(ProductName Pname:String, withDescrption descp:String,images:[UIImage],signature:UIImage,order:Order, completion: @escaping (_ resetInfo: String?, _ error: String?) -> Void) {
        
       let dict =  setupParamter(Pname: Pname, descp: descp, images: images, signature: signature, order: order)
        urlFactory.webServicRaiseRequest(methodName: RaiseRequestApi, with: dict) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            completion(info , nil)
                            
                        }
                        return
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    func setupParamter(Pname:String,descp:String,images:[UIImage],signature:UIImage,order:Order) -> [String:Any] {
        
        let signaturName = "\(order.user!.first_name ?? "TestFailed").png"
        let resizedImage = signature.jpeg(.low)
        let signaureImageContent = resizedImage!.base64EncodedString()
        var arrayDict = [Dictionary<String, Any>]()
        for index in 0..<images.count {
            let image = images[index]
            let imageName = "\(String(describing: descp))\(String(index)).png"
            let resizedImage = image.jpeg(.low)
            let imageContent = resizedImage!.base64EncodedString()
            let dict = ["image_name":imageName,
                        "image_content":imageContent]
            arrayDict.append(dict)
        }
        
        let dict = ["product_name":Pname,
                    "description":descp,
                    "images":arrayDict,
                    "signature_image_name": signaturName,
                    "signature_image_content": signaureImageContent] as [String : Any]
        
        return dict
    }
    
    func getAllRequest(userId:String, completion: @escaping (_ orderArray: [Order]?, _ error: String?) -> Void) {
        
        let dict = ["user_id":userId]
        print(dict)
        urlFactory.webServiceCall(methodName: GetAllRequestApi, with: dict) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if (jsonResult["Code"] as? String) != nil {
                        let errorCode = jsonResult["Code"] as! String
                        let info = jsonResult["status_message"] as! String
                        if Int(errorCode) != 200 {
                            completion(nil , info)
                        }else{
                            if let array = jsonResult["data"] as? [[String:Any]]{
                                let arryOrder = self.setupOrder(array: array)
                                completion(arryOrder , nil)
                            }
                            
                        }
                    }else{
                          completion([] , "Unknown Error")
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    func setupOrder(array:[[String:Any]]) -> [Order]{
        var arryOrder :Array<Order> = []

        for dic in array {
            var order = Order()
            if let orderid = dic["orderid"] as? String{
                order.orderID = orderid
            }
            if let description = dic["description"] as? String{
                order.issue = description
            }
            if let created_date = dic["created_date"] as? String{
                order.createdAt = ChangeDateFormat(created_date)
            }
            if let signature = dic["signature"] as? String{
                order.signatureUrl = signature
            }
            if let images = dic["images"] as? [String]{
                order.imagesArray = images
            }
            if let product_name = dic["product_name"] as? String{
                order.product = product_name
            }
            if let status = dic["status"] as? String{
                order.status = status
            }
            if let title = dic["title"] as? String{
                order.title = title
            }
            if let uid = dic["uid"] as? String{
                order.uid = uid
            }
            if let updateDate = dic["updated_date"] as? String{
                order.updatedDate = updateDate
            }
            arryOrder.append(order)
        }
        
        return arryOrder
    }

}
/*
 

 uid = 25;
 "updated_date" = "";
 */

