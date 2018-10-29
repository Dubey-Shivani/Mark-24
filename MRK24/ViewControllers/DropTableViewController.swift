//
//  DropTableViewController.swift
//  SignatureDemo
//
//  Created by LOKESH  yadav on 10/24/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit

class DropTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableview: UITableView!
    var arr :Array<String> = ["Desktop", "Server", "Laptop","Mobile"]
    var completionBlock : passDataBlock?

    override func viewDidLoad() {
        super.viewDidLoad()
   
        print(arr.count)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as! DropDownTableViewCell
        cell.lblText.text = arr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = arr[indexPath.row]
        if let dataBlock = completionBlock {
            dataBlock(str)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
  

}
