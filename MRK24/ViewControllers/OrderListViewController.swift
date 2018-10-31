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
    var originalMainOrderArray: Array<Order> = []
    var productType = ProductType.None
    var orderType = OrderStatus.None
    
    
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
                self.originalMainOrderArray = self.orderArray
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
        cell.lblSubmitdate.text = order.createdAt
        cell.viewBtn.tag = indexPath.row
        cell.viewBtn.addTarget(self, action: #selector(btnViewPhoto), for: .touchUpInside)
        return cell
        
    }
    @objc func btnViewPhoto(sender:UIButton)  {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
            {
                let order  = orderArray[sender.tag]
                if order.imagesArray.isEmpty{
                    TWMessageBarManager.sharedInstance().showMessage(withTitle: "Message", description: "No Photos", type: .error)
                    return
                }
                controller.imageStrArr = order.imagesArray
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
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if !(searchBar.text?.isEmpty)! {
            // self.actorArray.sort(by: { ($0.name!, $0.country!) < ($1.name!,$1.country!)})
            //product_name filter
            self.orderArray = originalOrderArray.filter({($0.orderID?.uppercased().contains(searchBar.text!))!})
           // self.orderArray.sort(by: { ($0.orderID!, $0.product!) < ($1.orderID!,$1.product!)})
           // self.actorArray = originalactorArray.filter({($0.name?.uppercased().contains(searchBar.text!))!})

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
        }else{
            searchBar.text = searchText.uppercased()
            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = UIColor.white
        }
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
    func setfilterOption(product: ProductType, orderS: OrderStatus) {
        productType = product
        orderType = orderS
        setupOriginalData()
        if product != .None {
            orderArray = originalOrderArray.filter({($0.product?.uppercased().contains(product.rawValue))!})
            originalOrderArray = orderArray
        }
        if orderS != .None {
            orderArray = originalOrderArray.filter({($0.status?.uppercased().contains(orderS.rawValue))!})
            originalOrderArray = orderArray

        }
        tblView.setContentOffset(.zero, animated: true)
        tblView.reloadData()
    }

   func setupOriginalData() {
        orderArray = originalMainOrderArray
        originalOrderArray = orderArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? FilterViewController{
            controller.productType = productType
            controller.orderType = orderType
            controller.delegate = self
        }
    }
 

}
