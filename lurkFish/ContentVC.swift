//
//  ContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class ContentViewController: UIViewController, UIGestureRecognizerDelegate {
    var threadVM: ThreadViewModel?
    var rightEdger: UISwipeGestureRecognizer!
    var downSwipe: UIGestureRecognizer!
    var inter: UIPercentDrivenInteractiveTransition!
    var interacting = false
    
    convenience init() {
        self.init()
    }
    
    init(threadVM: ThreadViewModel) {
        self.threadVM = threadVM
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        
        rightEdger = UISwipeGestureRecognizer(target: self, action: "dismissSwipe:")
        rightEdger.direction = .Right
        rightEdger.delegate = self
        view.addGestureRecognizer(rightEdger)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.flatWhiteColor()
    }
    
    func dismissSwipe(g: UISwipeGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}