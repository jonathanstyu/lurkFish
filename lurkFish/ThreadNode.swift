//
//  ThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ThreadNode: ASCellNode {
//    var thumbNailNode: ASImageNode
    var titleNode: ASTextNode
    
    init(thread: Thread) {
//        thumbNailNode = ASImageNode()
        titleNode = ASTextNode()
        super.init()
        
        setUpSubNodesWithThread(thread)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let titleTextSize = titleNode.measure(constrainedSize)
        return titleTextSize
    }
    
    override func layout() {
        titleNode.frame = CGRectMake(0, 0, titleNode.calculatedSize.width, titleNode.calculatedSize.height)
    }
    
    func setUpSubNodesWithThread(thread: Thread) {
        titleNode.attributedString = NSAttributedString(string: thread.title as String!, attributes: [
            NSBackgroundColorDocumentAttribute: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Georgia", size: 18.0)!
            ])
        self.addSubnode(titleNode)
    }
    
}