//
//  RoundImage.swift
//  RoundButton
//
//  Created by Dips on 10/07/17.
//  Copyright © 2018 LawrenceM. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class RoundImage: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
    }
}
