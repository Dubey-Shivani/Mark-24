//
//  MyProfileViewController.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/26/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit

class MyProfileViewController: MRKBaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Profile"
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileViewTableCell", for: indexPath) as! MyProfileViewTableCell
        cell.textLabel?.text = "HI"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        let slidingViewController = self.slidingViewController()
        if slidingViewController?.currentTopViewPosition == .centered {
            slidingViewController?.anchorTopViewToRight(animated: true)
        } else {
            slidingViewController?.resetTopView(animated: true)
        }
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
