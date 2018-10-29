//
//  OrderListViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/24/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import TWMessageBarManager
import SVProgressHUD


class OrderListViewController: MRKBaseViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, FilterDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    var orderArray: Array<Order> = []
    var originalOrderArray: Array<Order> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order List"

        apiGetAllOrderRequest()
        // Do any additional setup after loading the view.
    }
    
    
    
    func apiGetAllOrderRequest() {
        SVProgressHUD.show()
        let userid =  CurrentUser.sharedInstance.id
        print(userid!)
        APIHandler.sharedInstance.getAllRequest(userId: userid!) { (ordersArray, errorInfo) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            if errorInfo == nil {
                self.orderArray = ordersArray!
                self.originalOrderArray = self.orderArray
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }

            }else{
                TWMessageBarManager.sharedInstance().showMessage(withTitle: "Error", description: errorInfo, type: .error)
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        let order  = orderArray[indexPath.row]
        cell.lblOrderId.text = order.orderID
        cell.lblProduct.text = order.product
        cell.lblProblem.text = order.issue
        cell.viewBtn.tag = indexPath.row
        cell.viewBtn.addTarget(self, action: #selector(btnViewPhoto), for: .touchUpInside)
        return cell
        
    }
    @objc func btnViewPhoto(sender:UIButton)  {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
            {
                navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func btnMenuAction(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
    }
    
    
    @IBAction func filterBtnAction(_ sender: UIBarButtonItem) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if !(searchBar.text?.isEmpty)! {
            
            self.orderArray = originalOrderArray.filter({($0.orderID?.uppercased().contains(searchBar.text!))!})
            
            tblView.reloadData()
        } else {
            tblView.reloadData()
        }
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        if searchText.isEmpty {
            orderArray = originalOrderArray
            tblView.reloadData()
            
        }
        searchBar.text = searchText.uppercased()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        orderArray = originalOrderArray
        searchbar.text = ""
        searchBar.resignFirstResponder()
        tblView.reloadData()
    }
    func setPredicate(predicate: NSCompoundPredicate) {
        print(predicate)
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
