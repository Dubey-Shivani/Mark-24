//
//  FilterViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/25/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
protocol FilterDelegate: class{
    func setfilterOption(product:ProductType,orderS:OrderStatus)
}
class FilterViewController: UIViewController {
    var btnselected :Bool = false
    var delegate: FilterDelegate?
    @IBOutlet weak var bottomContraintPickerView: NSLayoutConstraint!
    @IBOutlet weak var btnDektop: UIButton!
    @IBOutlet weak var btnLaptop: UIButton!
    @IBOutlet weak var btnServer: UIButton!
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var frmDateLblText: UILabel!
    
    @IBOutlet weak var toDateLblText: UILabel!
    @IBOutlet weak var btnInProgress: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    var dateStr :String?
    var isFromDate :Bool  = false
    var productType = ProductType.None
    var orderType = OrderStatus.None

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"

        if productType != .None  || orderType != .None {
            setUp()
        }
        
        // Do any additional setup after loading the view.
    }

    func setUp() {
        switch productType {
        case .Desktop:
            btnDektop.isSelected = true
        case .Laptop:
            btnLaptop.isSelected = true
        case .Server:
            btnServer.isSelected = true
        case .Mobile:
            btnMobile.isSelected = true
        default:
            print("NONE")
        }
        
        
        switch orderType {
        case .InProgress:
            btnInProgress.isSelected = true
        case .Completed:
            btnCompleted.isSelected = true
        default:
            print("NONE")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        bottomContraintPickerView.constant =  -245
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        })
        
        if isFromDate {
            frmDateLblText.text = dateStr
        }else{
            toDateLblText.text = dateStr
        }
        
//        if let fromDate = frmDateLblText.text, let toDate = toDateLblText.text  {
//            if !fromDate.isEmpty && !toDate.isEmpty{
//
//                if let dateFrom = dateFromStr(dateStr: fromDate) as? NSDate, let dateTo = dateFromStr(dateStr: toDate) as? NSDate{
//                   // predicate3  = NSPredicate(format:"date >= %@ && date <= %@ ", dateFrom as CVarArg, dateTo as CVarArg)
//
//                }
//            }
//        }
    }
    
    func dateFromStr(dateStr:String) -> Date {
        let formtter = DateFormatter()
        formtter.dateFormat = "yyyy-MM-dd"
        let date = formtter.date(from: dateStr)
        return date!
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        bottomContraintPickerView.constant =  -245
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        })
       
    }
    @IBAction func datepickerAction(_ sender: Any) {
        let formtter = DateFormatter()
        formtter.dateFormat = "yyyy-MM-dd"
        let dateTime = datepicker.date
        dateStr = formtter.string(from: dateTime)
        
    }
    @IBAction func fromDateBtnAction(_ sender: Any) {
        
        isFromDate = true
        bottomContraintPickerView.constant =  bottomContraintPickerView.constant == -245 ? 0 : -245
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func toDateBtnAction(_ sender: Any) {
        isFromDate = false
        bottomContraintPickerView.constant =  bottomContraintPickerView.constant == -245 ? 0 : -245
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func btnSelectProductAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 101 {
            btnDektop.isSelected = sender.isSelected
            btnLaptop.isSelected = false
            btnServer.isSelected = false
            btnMobile.isSelected = false
            productType = sender.isSelected ? .Desktop : .None
        }else if sender.tag == 102{
            btnDektop.isSelected = false
            btnLaptop.isSelected = sender.isSelected
            btnServer.isSelected = false
            btnMobile.isSelected = false
            productType = sender.isSelected ? .Laptop : .None
        }else if sender.tag == 103{
            btnDektop.isSelected = false
            btnLaptop.isSelected = false
            btnServer.isSelected = sender.isSelected
            btnMobile.isSelected = false
            productType = sender.isSelected ? .Server : .None
        }else {
            btnDektop.isSelected = false
            btnLaptop.isSelected = false
            btnServer.isSelected = false
            btnMobile.isSelected = sender.isSelected
            productType = sender.isSelected ? .Mobile : .None
        }
        
    }
    
    
    @IBAction func btnSelectStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.tag == 105 {
            btnInProgress.isSelected = sender.isSelected
            btnCompleted.isSelected = false
            orderType = sender.isSelected ? .InProgress : .None
            
        }else{
            btnInProgress.isSelected = false
            btnCompleted.isSelected = sender.isSelected
            orderType = sender.isSelected ? .Completed : .None
        }
        
       // predicate2 = NSPredicate(format: ("Status CONTAINS[c] %@"), strValue!)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        //let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2, predicate3])
       // delegate?.setPredicate(predicate: predicateCompound)
        if let fromDate = frmDateLblText.text, let toDate = toDateLblText.text {
            if fromDate == "From Date" || toDate == "To Date"{
                print(fromDate)
                print(toDate)
            }
        }
        
        delegate?.setfilterOption(product: productType, orderS: orderType)
        navigationController?.popViewController(animated: true)

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
