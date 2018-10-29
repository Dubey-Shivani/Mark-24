//
//  changePasswordViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/20/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import TWMessageBarManager
import SVProgressHUD

class ResetPasswordViewController: UIViewController {

    
    @IBOutlet weak var txtfieldemailId: UITextField!
    @IBOutlet weak var txtfieldNewPaswd: UITextField!
    @IBOutlet weak var txtfieldConfirmPaswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RESET PASSWORD"
        txtfieldemailId.placeHolderTextColor = UIColor.lightText
        txtfieldNewPaswd.placeHolderTextColor = UIColor.lightText
        txtfieldConfirmPaswd.placeHolderTextColor = UIColor.lightText
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeBtnAction(_ sender: Any) {
        
        view.endEditing(true)
        let response = Validation.shared.validate(values: (ValidationType.email, txtfieldemailId.text!))
        switch response {
        case .success:
            print("Success")
            apiforgot(emailId: txtfieldemailId.text!, paswd: txtfieldConfirmPaswd.text!)
            break
            
        case .failure(_, let message):
            Validation.shared.alertWithMessage(title: "Alert", message: message.localized(), vc: self)
       }
        
        
    }
    
    
    func apiforgot(emailId:String,paswd:String) {
        SVProgressHUD.show()
        
        APIHandler.sharedInstance.resetPassword(UserEmailId: emailId, withPassword: paswd) { (successInfo, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if errorInfo == nil {
                let alertController = AlertController(title: "SUCCESS", message: successInfo!)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.tapNoSignupBlock = {
                    DispatchQueue.main.async {
                        //User.sharedInstance.dispose()
                        let mainStoreBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = mainStoreBoard.instantiateViewController(withIdentifier: "LoginNav")
                        UIApplication.shared.keyWindow?.rootViewController = controller
                    }
                    
                }
                self.present(alertController, animated: false, completion: nil)
                
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error", description: errorInfo, type: .error)
            }
        }
        
    }

    @IBAction func submitBtnACtion(_ sender: UIButton) {
        if txtfieldNewPaswd.text == txtfieldConfirmPaswd.text{
            print("match")
        }else{
            print("No")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
