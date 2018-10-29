//
//  FTSideMenuTableViewCell.swift
//  Ardhi
//
//  Created by Alex Zdorovets on 9/21/15.
//  Copyright (c) 2015 Solutions 4 Mobility. All rights reserved.
//

import UIKit

class FTSideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    
 
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: - Setup
    
//    override func setup(withItem item: Any!) {
//        let menuItem = item as! FTMenuItem
//        self.labelTitle.text = NSLocalizedString( menuItem.title!, comment: "").uppercased()
//    }
    
}
