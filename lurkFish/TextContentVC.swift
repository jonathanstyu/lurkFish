//
//  TextContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/31/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class TextContentViewController: ContentViewController {
    var textVC: JYTextController!
    
    override init(threadVM: ThreadViewModel) {
        super.init(threadVM: threadVM)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        textVC = JYTextController(title: threadVM!.title!, body: threadVM!.bodyText!)
        view.backgroundColor = UIColor.flatWhiteColor()
        self.addChildViewController(textVC)
        textVC.didMoveToParentViewController(self)
        self.view.addSubview(textVC.view)
    }    

}