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
    
    convenience init() {
        self.init()
    }
    
    init(threadVM: ThreadViewModel) {
        self.threadVM = threadVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}