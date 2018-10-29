//
//  OrderListTableViewCell.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/25/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblProblem: UILabel!
    @IBOutlet weak var lblSubmitdate: UILabel!
    @IBOutlet weak var lblStatusProgress: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
