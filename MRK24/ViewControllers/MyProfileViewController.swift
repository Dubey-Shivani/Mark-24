//
//  MyProfileViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/26/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import TWMessageBarManager
import SVProgressHUD
import MobileCoreServices

class MyProfileViewController: MRKBaseViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    fileprivate enum SourceType {
        case gallery, camera
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var cust =  Customer.init(id: CurrentUser.sharedInstance.id ?? "", username: CurrentUser.sharedInstance.username ?? "", first_name: CurrentUser.sharedInstance.first_name ?? "", last_name: CurrentUser.sharedInstance.last_name ?? "", email_id: CurrentUser.sharedInstance.email_id ?? "", address: CurrentUser.sharedInstance.address ?? "", city: CurrentUser.sharedInstance.city ?? "", state: CurrentUser.sharedInstance.state ?? "", country: CurrentUser.sharedInstance.country ?? "", phone_number: "", password: "", devicetoken: "", createdTime: Date())
    
    var customerPlaceholders =  CustomerEdit.customersEdit
    
    @IBOutlet weak var tblview: CXTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Profile"
        if  let url = URL(string: CurrentUser.sharedInstance.profileImage ?? ""){
            profileImage.sd_setImage(with: url, completed: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customerPlaceholders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUPTableViewCell", for: indexPath) as! SignUPTableViewCell
        let placeholderKey = customerPlaceholders[indexPath.row].rawValue
        cell.txtField.placeholder = placeholderKey
        cell.txtField.placeHolderTextColor = UIColor.lightText
        cell.txtField.delegate = self
        if cust.username.count > 0, indexPath.row == 0 {
            cell.txtField.text = cust.username
        }
        if cust.first_name.count > 0, indexPath.row == 1 {
            cell.txtField.text = cust.first_name
        }
        if cust.last_name.count > 0, indexPath.row == 2 {
            cell.txtField.text = cust.last_name
        }
        if cust.email_id.count > 0, indexPath.row == 3 {
            cell.txtField.text = cust.email_id
        }
        if cust.address.count > 0, indexPath.row == 4 {
            cell.txtField.text = cust.address
        }
        if cust.city.count > 0, indexPath.row == 5 {
            cell.txtField.text = cust.city
        }
        if cust.state.count > 0, indexPath.row == 6 {
            cell.txtField.text = cust.state
        }
        if cust.country.count > 0, indexPath.row == 7 {
            cell.txtField.text = cust.country
        }
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
        } else{
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
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
            cust.city = textField.text!
        case 6:
            cust.state = textField.text!
        case 7:
            cust.country = textField.text!
        default:
            cust.password = textField.text!
            
        }
    }
    
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if cust.email_id.isEmpty || cust.first_name.isEmpty || profileImage.image == nil {
            return
        }
        apiProfileEdit(cust: cust)
    }
    
    
    
    func apiProfileEdit(cust:Customer) {
        SVProgressHUD.show()

        APIHandler.sharedInstance.profileUpdateRequest(customer:cust, profileImage: profileImage.image) { (editInfo, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if errorInfo == nil {
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Success", description: editInfo, type: .success)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: KupdateUserProfile), object: nil, userInfo: nil)

                    if let boolval = UserDefaults.standard.get(key: kCurrentUserIsRemember) as? Bool{
                        if boolval{
                            if let dataToSave = NSKeyedArchiver.archivedData(withRootObject: APIHandler.sharedInstance.currentUser) as? Data{
                                UserDefaults.standard.set(value: dataToSave, key: kCurrentUser, synchronize: true)
                            }
                        }
                    }
                   
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
    
    // MARK: - Profile image
    
    fileprivate func pickImage(_ fromSource: SourceType) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
        
        switch fromSource {
        case .gallery:
            imagePicker.sourceType = .photoLibrary
        case .camera:
            imagePicker.sourceType = .camera
        }
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        DispatchQueue.main.async {
            self.navigationController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func profilePicClickAction(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickImage(.gallery)
            return
        }
        
        let actionSheet = UIAlertController(title: nil, message: "Select", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {[weak self] (action) in
            self?.pickImage(.gallery)
        }))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {[weak self] (action) in
            self?.pickImage(.camera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.navigationController?.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        // Handle image
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        profileImage.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}
