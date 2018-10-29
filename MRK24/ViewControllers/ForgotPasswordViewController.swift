//
//  ForgotPasswordViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/19/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import TWMessageBarManager
import SVProgressHUD


class ForgotPasswordViewController: MRKBaseViewController {

    @IBOutlet weak var txtfieldEmailId: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FORGOT PASSWORD"
        txtfieldEmailId.placeHolderTextColor = UIColor.lightText


        // Do any additional setup after loading the view.
    }

    @IBAction func changeBtnAction(_ sender: Any) {
        view.endEditing(true)
        let response = Validation.shared.validate(values: (ValidationType.email, txtfieldEmailId.text!))
        switch response {
        case .success:
            print("Success")
            apiforgot(emailId: txtfieldEmailId.text!)
            break
        case .failure(_, let message):
            Validation.shared.alertWithMessage(title: "Alert", message: message.localized(), vc: self)
            
        }
    }
    
    func apiforgot(emailId:String) {
        SVProgressHUD.show()
        APIHandler.sharedInstance.forgotPassword(userEmailId: emailId) { (successInfo, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if errorInfo == nil {
                let alertController = AlertController(title: "SUCCESS", message: successInfo!)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.tapNoSignupBlock = {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                self.present(alertController, animated: false, completion: nil)
          
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error", description: errorInfo, type: .error)
            }
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
