//
//  ViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/18/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import RSFloatInputView
import TWMessageBarManager
import SVProgressHUD

class SignInViewController: MRKBaseViewController,UITextFieldDelegate {
    @IBOutlet weak var textFieldUserName: RSFloatInputView!
    @IBOutlet weak var textFieldPassword: RSFloatInputView!
    var isRemember :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldPassword.textField.isSecureTextEntry = true
        setupLoginCredential()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setupLoginCredential() {
        if let userData = UserDefaults.standard.value(forKey: kCurrentUser) as? Data{
            if let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? CurrentUser{
                APIHandler.sharedInstance.currentUser = user
            }
           
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == ""{
            return true
        }
        return true
    }
    
    @IBAction func btnRememberAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        isRemember = sender.isSelected ? true : false
        UserDefaults.standard.set(value: sender.isSelected, key: kCurrentUserIsRemember, synchronize: true)

    }
    @IBAction func signInBtnAction(_ sender: Any) {
       //textFieldUserName.textField.text = "Lokesh1801@gmail.com"
        //textFieldPassword.textField.text = "12345678"
        let user_email = textFieldUserName.textField.text
        let password = textFieldPassword.textField.text
     
        view.endEditing(true)
        let response = Validation.shared.validate(values: (ValidationType.email, user_email!))
        switch response {
        case .success:
            print("Success")
            apiSignIn(userName: user_email!, password: password!)
            break
        case .failure(_, let message):
            print(message.localized())
            Validation.shared.alertWithMessage(title: "Alert", message: message.localized(), vc: self)
           // performSegue(withIdentifier: "SliderStoryboardSeque", sender: nil)
        }
    }
    
    func apiSignIn(userName:String, password:String) {
        SVProgressHUD.show()
        APIHandler.sharedInstance.login(userName: userName, withPassword: password) { (customer, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil {
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Success", description: "", type: .success)
                if self.isRemember{
                    if let dataToSave = NSKeyedArchiver.archivedData(withRootObject: APIHandler.sharedInstance.currentUser) as? Data{
                        UserDefaults.standard.set(value: dataToSave, key: kCurrentUser, synchronize: true)
                    }
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "SliderStoryboardSeque", sender: nil)
                }
            }else{
              TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error", description: error, type: .error)
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

