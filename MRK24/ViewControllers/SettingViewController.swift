//
//  SettingViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/19/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
//import ECSlidingViewController
class SettingViewController: MRKBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tbleView: UITableView!
    
    var menuItemsArray : Array<FTSettingMenuitem> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "SETTING"
       // self.slidingViewController().anchorRightPeekAmount = 70

        self.edgesForExtendedLayout = [UIRectEdge.top, UIRectEdge.bottom, UIRectEdge.left]

        menuItemsArray = FTSettingMenuitem.menuItems
        
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
        return menuItemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        let menuitem = menuItemsArray[indexPath.row]
        cell.labelTitle.text = menuitem.title

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuitem = menuItemsArray[indexPath.row]
        if menuitem.title == "LOGOUT" {
            CurrentUser.sharedInstance.dispose()
            let mainStoreBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = mainStoreBoard.instantiateViewController(withIdentifier: "LoginNav")
            UIApplication.shared.keyWindow?.rootViewController = controller

        }else{
            performSegue(withIdentifier: menuitem.segueIdentifier, sender: nil)
        }

        
    }
    
   
}
