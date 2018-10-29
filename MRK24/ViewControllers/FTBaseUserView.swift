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
        self.avatarImageView.image = CurrentUser.sharedInstance.profileImage
    }
    
//    override func setup(withItem item: Any!) {
//        if let user = item as? User {
//            self.avatarImageView.setImage(user.avatarURL!, placeholder: UIImage(named: "avatar_placeholder"))
//        }
//    }
    
}
