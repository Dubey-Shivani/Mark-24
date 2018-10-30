//
//  SecondViewController.swift
//  SlidingDemoCode
//
//  Created by LOKESH  yadav on 6/7/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import ECSlidingViewController
let KupdateUserProfile = "KuserProfile"
class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var userBaseView: FTBaseUserView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var tbleView: UITableView!
    var menuItemsArray : Array<FTMenuItem> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.slidingViewController().topViewAnchoredGesture = [ECSlidingViewControllerAnchoredGesture.tapping, ECSlidingViewControllerAnchoredGesture.panning]
        self.slidingViewController().anchorRightPeekAmount = 70
        self.edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left]
        menuItemsArray = FTMenuItem.menuItems
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: NSNotification.Name(rawValue: KupdateUserProfile), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something now
        userBaseView.setup()
        setup()
    }
    func setup(){
        
        userNameLbl.text = CurrentUser.sharedInstance.username ?? CurrentUser.sharedInstance.first_name
    }
   
    @IBAction func btnProfileAction(_ sender: Any) {
       
        performSegue(withIdentifier: "MyProfileViewControllerSegueIdentifier", sender: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FTSideMenuTableViewCell", for: indexPath) as! FTSideMenuTableViewCell
        let menuitem = menuItemsArray[indexPath.row]
        cell.labelTitle.text = menuitem.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuitem = menuItemsArray[indexPath.row]
        performSegue(withIdentifier: menuitem.segueIdentifier, sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(segue.identifier)
        print(segue.destination)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */

}
