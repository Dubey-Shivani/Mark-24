//
//  SignUpViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/18/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import TWMessageBarManager
import SVProgressHUD

class SignUpViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    var cust =  Customer.init(id: "", username: "", first_name: "", last_name: "", email_id: "", address: "", city: "", state: "", country: "", phone_number: "", password: "", devicetoken: "", createdTime: Date())
    var customerPlaceholders =  CustomerReg.customers
    
    @IBOutlet weak var tblview: CXTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SIGN UP"
        // Do any additional setup after loading the view.
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customerPlaceholders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUPTableViewCell", for: indexPath) as! SignUPTableViewCell
        cell.txtField.placeholder = customerPlaceholders[indexPath.row].rawValue
        cell.txtField.placeHolderTextColor = UIColor.lightText
        cell.txtField.delegate = self
        cell.txtField.tag = indexPath.row
        return cell
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        if textField.tag == 3 {
            let response = Validation.shared.validate(values: (ValidationType.email, textField.text!))
            switch response {
            case .success:
                print("Success")
                break
            case .failure(_, let message):
                print(message.localized())
                Validation.shared.alertWithMessage(title: "Alert", message: message.localized(), vc: self)
            }
        }else{
            textField.resignFirstResponder()
        }
        
        return true
        
        
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
       if textField.tag == 3 {
            textField.keyboardType = .emailAddress
       }else if textField.tag == 5{
            textField.keyboardType = .phonePad
        }else{
            textField.keyboardType = .default
        }
        if textField.tag == 9 || textField.tag == 10{
            textField.isSecureTextEntry = true
        }else{
            textField.isSecureTextEntry = false

        }
    }
    

    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            cust.username = textField.text!
        case 1:
            cust.first_name = textField.text!
        case 2:
            cust.last_name = textField.text!
        case 3:
            cust.email_id = textField.text!
        case 4:
            cust.address = textField.text!
        case 5:
            cust.phone_number = textField.text!
        case 6:
            cust.city = textField.text!
        case 7:
            cust.state = textField.text!
        case 8:
            cust.country = textField.text!
        default:
            cust.password = textField.text!

        }
    }
    
  

    @IBAction func submitBtnAction(_ sender: Any) {
  
        if cust.email_id.isEmpty || cust.password.isEmpty || cust.first_name.isEmpty {
            return
        }
        apiRegisteration(cust: cust)
    }
    
   
    
    func apiRegisteration(cust:Customer) {
        SVProgressHUD.show()
        APIHandler.sharedInstance.registration(customer: cust) { (registerInfo, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if errorInfo == nil {
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Success", description: registerInfo, type: .success)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }

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
