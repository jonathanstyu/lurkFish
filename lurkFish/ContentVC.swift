//
//  ContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class ContentViewController: UIViewController {
    var threadVM: ThreadViewModel?
    var swipeLeft: UISwipeGestureRecognizerDirection
    var swipeRight: UISwipeGestureRecognizerDirection
    
    convenience init() {
        self.init()
    }
    
    init(threadVM: ThreadViewModel) {
        self.threadVM = threadVM
        swipeLeft = UISwipeGestureRecognizerDirection.Left
        swipeRight = UISwipeGestureRecognizerDirection.Right
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.flatWhiteColor()
        
        let bodytext = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 14.0)!
        ]
        
        bodytext.attributedText = NSAttributedString(string: (self.threadVM?.bodyText!)!, attributes: attributes)
        self.view.addSubview(bodytext)
    }
    
}