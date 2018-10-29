//
//  AlertController.swift
//  Ardhi
//
//  Created by Vlad Gorbenko on 5/24/16.
//  Copyright © 2016 Solutions 4 Mobility. All rights reserved.
//

import UIKit

typealias UIAlertActionHandlerSignup = @convention(block) (UIAlertAction) -> Void;
typealias TapYesSignupBlock = () -> Void
typealias TapNoSignupBlock = () -> Void

class AlertController: UIViewController {
    var tapYesSignupBlock: TapYesSignupBlock?
    var tapNoSignupBlock: TapNoSignupBlock?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet fileprivate var buttons: [UIButton]!
    @IBOutlet fileprivate var views: [UIView]!
    
    //    var title: String?
    var message: String?
    var actions = Array<UIAlertAction>()
    
    fileprivate var selectedItem: UIButton?
    
    //MARK: - Initialization
    
    convenience init(title: String?, message: String?) {
        self.init(nibName: nil, bundle: nil)
        self.title = title
        self.message = message
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        let nib = nibNameOrNil ?? "AlertController"
        super.init(nibName: nib, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.title
        self.messageLabel.text = self.message
        for i in 0 ..< self.actions.count {
            let button = self.buttons[i]
            button.setTitle(actions[i].title, for: UIControlState())
        }
        for i in self.actions.count..<self.buttons.count {
            let button = self.views[i]
            button.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let selected = self.selectedItem, let index = self.buttons.index(of: selected) {
//            let action = self.actions[index]
//            if let handler = action.value(forKey: "handler") {
//                let handlerBlock = unsafeBitCast(handler, to: UIAlertActionHandlerSignup.self) as UIAlertActionHandlerSignup
//                handlerBlock(action)
//            }
            if index == 1 {
                self.tapYesSignupBlock?()
            }else{
                self.tapNoSignupBlock?()
            }
        }
        
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //let width = CGFloat(120)
        //let height = CGFloat(48)
        //let x = self.container.bounds.width / 2 - (CGFloat(self.actions.count) * width) / 2
//        for i in 0 ..< views.count {
//            let frame = CGRect(x: x + (CGFloat(i) * width), y: 0, width: width, height: height)
//            self.views[i].frame = frame
//        }
    }
    
    //MARK: - Setup
    
    fileprivate func setup() {        
    }
    
    //MARK: -
    
    func addAction(_ action: UIAlertAction) {
        actions.append(action)
    }
    
    //MARK: - User interaction
    
    @IBAction func tap(_ sender: UIButton) {
        self.selectedItem = sender
        self.dismiss(animated: false, completion: nil)
    }
}
