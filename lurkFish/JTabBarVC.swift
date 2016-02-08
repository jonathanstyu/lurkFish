//
//  JTabBarVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

class JTabBar: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        let newTabFrameHeight: CGFloat = 43.0
        
        tabFrame.size.height = newTabFrameHeight
        tabFrame.origin.y = self.view.frame.size.height - newTabFrameHeight
        self.tabBar.frame = tabFrame
    }
    
}