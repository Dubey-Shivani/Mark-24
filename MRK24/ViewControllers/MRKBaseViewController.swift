//
//  FTBaseViewController.swift
//  Ardhi
//
//  Created by Alex Zdorovets on 9/16/15.
//  Copyright (c) 2015 Solutions 4 Mobility. All rights reserved.
//

import UIKit

class MRKBaseViewController: UIViewController {
    
    //@IBOutlet var menuButton : UIBarButtonItem?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let root = (self.navigationController?.viewControllers.count)! < 2
//        if self.menuButton != nil && root {
//            let image = UIImage(named: "Menubtn")
//            let button = UIButton(type: UIButtonType.system) as UIButton
//            button.bounds = CGRect(x: 0, y: 0, width: image!.size.width, height: image!.size.height)
//            button.setImage(image, for: UIControlState())
//            button.addTarget(self, action: #selector(MRKBaseViewController.toggleSlideMenu(_:)), for: UIControlEvents.touchUpInside)
//            let barButtonItem = UIBarButtonItem(customView: button)
//            self.navigationItem.leftBarButtonItem = barButtonItem
//        } else {
//            self.navigationItem.leftBarButtonItem = nil;
//        }
        
        
        setupNavigationWithColor(.white)
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton;
        
    
    }
    
//    @objc func toggleSlideMenu(_ sender : UIButton) {
//        let slidingViewController = self.slidingViewController()
//        if slidingViewController?.currentTopViewPosition == .centered {
//            slidingViewController?.anchorTopViewToRight(animated: true)
//        } else {
//            slidingViewController?.resetTopView(animated: true)
//        }
//    }
    
    func setupNavigationWithColor(_ color: UIColor) {
        let font = UIFont.systemFont(ofSize: 16)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font : font as Any]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    //MARK: - Modifiers
    
    override var title : String? {
        didSet {
            super.title = title?.uppercased()
        }
    }
    
   
   
}
