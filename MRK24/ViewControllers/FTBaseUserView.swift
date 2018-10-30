//
//  FTBaseUserView.swift
//  Ardhi
//
//  Created by vlad gorbenko on 1/5/16.
//  Copyright © 2016 Solutions 4 Mobility. All rights reserved.
//

import UIKit

class FTBaseUserView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    //MARK: - Setup
    
    func setup() {
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2
        self.avatarImageView.superview!.layer.cornerRadius = self.avatarImageView.superview!.frame.size.height / 2
        self.avatarImageView.superview!.layer.borderWidth = 1
        self.avatarImageView.superview!.layer.borderColor = UIColor.white.cgColor
        if  let url = URL(string: CurrentUser.sharedInstance.profileImage ?? ""){
            self.avatarImageView.sd_setImage(with: url, completed: nil)
        }

    }
    
}
