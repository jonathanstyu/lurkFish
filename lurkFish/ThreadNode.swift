//
//  ThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ThreadNode: ASCellNode {
    var titleNode: ASTextNode
    var cellInsetMargin: CGFloat = 10.0
    var cellSizeWidth: CGFloat = 0.0
    var cellSizeHeight: CGFloat = 0.0
    
    init(thread: Thread) {
        titleNode = ASTextNode()
        super.init()
        setUpSubNodesWithThread(thread)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let newConstrainedSize = CGSize(width: constrainedSize.width - 10.0, height: constrainedSize.height)
        let titleNodeSize = titleNode.measure(newConstrainedSize)
        
        cellSizeWidth += titleNodeSize.width
        cellSizeHeight += titleNodeSize.height
        
        return CGSizeMake(titleNodeSize.width + 10, cellSizeHeight + 2 * cellInsetMargin)
    }
    
    override func layout() {
        titleNode.frame = CGRectMake(cellInsetMargin, cellInsetMargin, titleNode.calculatedSize.width, titleNode.calculatedSize.height)
    }
    
    func setUpSubNodesWithThread(thread: Thread) {
        titleNode.attributedString = NSAttributedString(string: thread.title as String!, attributes: [
            NSBackgroundColorDocumentAttribute: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Georgia", size: 18.0)!
            ])
        self.addSubnode(titleNode)
    }
}