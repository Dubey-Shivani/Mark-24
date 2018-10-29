//
//  FilterViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/25/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
protocol FilterDelegate: class{
    func setPredicate(predicate: NSCompoundPredicate )
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
    
    var predicate1 = NSPredicate()
    var predicate2 = NSPredicate()
    var predicate3 = NSPredicate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"

        // Do any additional setup after loading the view.
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
        
        if let fromDate = frmDateLblText.text, let toDate = toDateLblText.text  {
            if !fromDate.isEmpty && !toDate.isEmpty{

                if let dateFrom = dateFromStr(dateStr: fromDate) as? NSDate, let dateTo = dateFromStr(dateStr: toDate) as? NSDate{
                    predicate3  = NSPredicate(format:"date >= %@ && date <= %@ ", dateFrom as CVarArg, dateTo as CVarArg)

                }
            }
        }
    }
    
    func dateFromStr(dateStr:String) -> Date {
        let formtter = DateFormatter()
        formtter.dateFormat = "dd/MM/yyyy"
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
        formtter.dateFormat = "dd/MM/yyyy"
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
        var strValue : String?
        if sender.tag == 101 {
            btnDektop.isSelected = true
            btnLaptop.isSelected = false
            btnServer.isSelected = false
            btnMobile.isSelected = false
           strValue = "Desktop"
        }else if sender.tag == 102{
            btnDektop.isSelected = false
            btnLaptop.isSelected = true
            btnServer.isSelected = false
            btnMobile.isSelected = false
            strValue = "Laptop"
        }else if sender.tag == 103{
            btnDektop.isSelected = false
            btnLaptop.isSelected = false
            btnServer.isSelected = true
            btnMobile.isSelected = false
            strValue = "Server"
        }else {
            btnDektop.isSelected = false
            btnLaptop.isSelected = false
            btnServer.isSelected = false
            btnMobile.isSelected = true
            strValue = "Mobile"
        }
        
        predicate1 = NSPredicate(format: ("Product CONTAINS[c] %@"), strValue!)
    }
    
    
    @IBAction func btnSelectStatus(_ sender: UIButton) {
        var strValue : String?
        sender.isSelected = !sender.isSelected
        if sender.tag == 105 {
            btnInProgress.isSelected = true
            btnCompleted.isSelected = false
            strValue = "In Process"
        }else{
            btnInProgress.isSelected = false
            btnCompleted.isSelected = true
            strValue = "Completed"
        }
        
        predicate2 = NSPredicate(format: ("Status CONTAINS[c] %@"), strValue!)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2, predicate3])
        delegate?.setPredicate(predicate: predicateCompound)


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
