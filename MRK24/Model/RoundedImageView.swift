//
//  RoundedImageView.swift
//  
//
//

import UIKit

@IBDesignable class RoundedImageView: UIImageView {

    /// saved rendition of border layer

    @IBInspectable var boderWidth: CGFloat = 0 {
        didSet {
            borderLayer?.lineWidth = boderWidth
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            borderLayer?.strokeColor = borderColor?.cgColor
        }
    }
    
    weak var borderLayer: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // create path
        
        let width = min(bounds.width, bounds.height)
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: width / 2, startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        // update mask and save for future reference
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        // create border layer
        
        let frameLayer = CAShapeLayer()
        frameLayer.path = path.cgPath
        frameLayer.lineWidth = self.boderWidth
        frameLayer.strokeColor = self.borderColor?.cgColor
        frameLayer.fillColor = nil
        
        // if we had previous border remove it, add new one, and save reference to new one
        
        self.borderLayer?.removeFromSuperlayer()
        layer.addSublayer(frameLayer)
        self.borderLayer = frameLayer
    }

}
