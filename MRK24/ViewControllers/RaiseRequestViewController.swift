//
//  RaiseRequestViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/20/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import ABSignatureView
import UITextView_Placeholder
import TWMessageBarManager
import SVProgressHUD
typealias passDataBlock = (_ stringToPass: String) -> Void


class RaiseRequestViewController: MRKBaseViewController, AddPhotoDelegate {
    
    @IBOutlet weak var lbltext: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var subViewTop: UIView!
    @IBOutlet weak var viewSignature: ABSignatureView!
    @IBOutlet weak var heightConstrant: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var bottomView: UIView!
    var imageArr :Array<UIImage> = []
    var isSendable:Bool = false
    
    
    
    var orderInfo  = Order()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Raise Request"
        heightConstrant.constant = 0
        descriptionTextView.placeholder = "Describe the issue"
        descriptionTextView.placeholderColor = UIColor.white
       // self.edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left]
        
        //shouldAllowPanningPastAnchor
        print(self.slidingViewController().anchorRightRevealAmount)
        self.slidingViewController().anchorRightRevealAmount = 0
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func btnDownUPAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            // dropdownView.isHidden = false
            UIView.animate(withDuration: 0.7) {
                self.heightConstrant.constant = 170
                self.view.layoutIfNeeded()
                
            }
            
        }else{
            //dropdownView.isHidden = true
            UIView.animate(withDuration: 0.7) {
                self.heightConstrant.constant = 0
                self.view.layoutIfNeeded()
                
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearbtnAction(_ sender: Any) {
        viewSignature.clear()
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        
         print(viewSignature.signatureImage())
        if let product = lbltext.text, let issue = descriptionTextView.text   {
            if product.isEmpty || issue.isEmpty || imageArr.count > 0 || viewSignature.hasSigned() == false{
                print("Please fill information")
                isSendable = false
                return
            }
           
            orderInfo.product = product
            orderInfo.issue = issue
            orderInfo.imagesArray = imageArr
            orderInfo.signature = viewSignature.signatureImage()
            let date = dateToString(Date())
            orderInfo.orderDate = date
            orderInfo.user = CurrentUser.sharedInstance
            isSendable = true
            
        }
        
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorRightRevealAmount = 344.0
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    @IBAction func addPhotoAction(_ sender: UIButton) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController{
            controller.delegate = self
            controller.isViewPhoto = false
            navigationController?.pushViewController(controller, animated: true)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? DropTableViewController {
            
            print(controller)
            controller.completionBlock = { [weak self] (data: String) in
                DispatchQueue.main.async {
                    self?.lbltext.text = data
                   // self.orderInfo?.product = data
                }
                UIView.animate(withDuration: 0.7) {
                    self?.heightConstrant.constant = 0
                    self?.view.layoutIfNeeded()
                    
                }
            }
        }
    }
    func sendImageByDelegate(arr: Array<UIImage>) {
        imageArr = arr
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if isSendable {
            print("you can submit")
            apiRaiserRequest()
        }else{
            TWMessageBarManager.sharedInstance().showMessage(withTitle: "Alert", description: "Please add all the Information", type: .error)
            
        }
    }
    
    func apiRaiserRequest() {
        SVProgressHUD.show()
        APIHandler.sharedInstance.raiserRequest(ProductName: orderInfo.product!, withDescrption: orderInfo.issue!, images: orderInfo.imagesArray, signature: orderInfo.signature!, order:orderInfo) { (successInfo, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            if errorInfo == nil {
               
                let alertController = AlertController(title: "SUCCESS", message: successInfo!)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                alertController.tapNoSignupBlock = {
                  
                }
                self.present(alertController, animated: false, completion: nil)
                DispatchQueue.main.async {
                    self.clear()
                }
                
            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error", description: errorInfo, type: .error)
            }
        }
       
    }
    
    func clear() {
        orderInfo = Order()
        viewSignature.clear()
        lbltext.text = ""
        descriptionTextView.text = ""
        imageArr.removeAll()
        isSendable = false
        
        
        
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
