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
        self.hidesBottomBarWhenPushed = true
        navigationController?.navigationBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.flatWhiteColor()
    }
    
}