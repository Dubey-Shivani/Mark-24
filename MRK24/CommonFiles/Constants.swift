

import Foundation
import UIKit

let storyboard = UIStoryboard(name: "Main", bundle: nil)

let appDelegate = UIApplication.shared.delegate as? AppDelegate

//Base url of App
let BASEURL = "http://help2help.weapplify.tech"

//Google APIs
let cinstantbaseUrl1 = "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyCMocapkvRdqw1WHLuouIp7FOA_H8OZ7Ng=true"


//AIzaSyCMocapkvRdqw1WHLuouIp7FOA_H8OZ7Ng
//265085728281-h2pc9one1qasr4b25lvvi3l0tsh4asqo.apps.googleusercontent.com

//Menu buttons on Navigation Bar (Right and Left) Buttons
var menuBtn = UIButton();
var rightBarBtn = UIButton();
var API_TOKEN = " "
var DEVICE_ID = ""
var SELECTED_NAME = ""
var SELECTED_IMAGE = UIImageView()
var SELECTED_IMAGE_URL = ""
var SC_ID = ""
var SRV_ID = ""
var SELECTED_DESC = ""
var CUST_EMAIL = ""
var CUST_PASSWORD = ""
var CUST_REFERAL_CODE = ""
var CUST_MOBILE_NO = ""
var CUST_LAST_NAME = ""
var CUST_FIRST_NAME = ""
var CUST_LANGUAGE = ""
var CUST_IS_ACTIVE = ""
var CUST_CREATEDBY = ""
var CUST_ID = ""
var SP_CATEGORY = ""
var SP_ID = ""
var ADDRESS = ""
var SELECTED_ADDRESS = ""
var SP_IMAGEURL = ""
var SP_NAME = ""
var TC_TXNID = ""
var SR_NO = ""
var ADD_ENTITYID = ""
var ADD_ENTITYTYPE = ""
var SR_TXNID = ""
var SELECTED_DATE = ""
var SELECTED_TIME = ""
var SELECTED_ADDRESS_ID = ""
var SELECTED_MESSAGEING = ""
var SELECTED_MOBILE_NO = ""
var SR_CUSTID = ""

//APP Font
//var APPFONT = "SanFranciscoText"

//var NAVIGATION_BAR_COLOR = #colorLiteral(red: 0.9647058824, green: 0.8941176471, blue: 0.01176470588, alpha: 1)


//View Controllers
var SIGNUP_VCID = "CreateAccountVCID"
var LOGIN_VCID = "LoginVCID"
var MAIN_VCID = "MainVCID"
var MENU_VCID = "MenuViewController"
var ABOUT_US_VCID = "AboutUsVCID"
var MY_REQUEST_VCID = "MyRequestVCID"
var SETTING_VCID = "SettingVCID"
var REGISTER_AS_PARTNER_VCID = "RegisterAsPartnerVCID"




extension String{
    
    func removeNil() -> String {
        
        if self != "nil" {
            return self
        }
        
        return ""
    }
    
}

