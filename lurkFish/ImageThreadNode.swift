//
//  ImageThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ImageThreadNode: ThreadNode {
    var imageNode: ASTextNode
    
    override init(thread: Thread) {
        imageNode = ASTextNode()
        super.init(thread: thread)
        setUpSubNodesWithThread(thread)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        super.calculateSizeThatFits(constrainedSize)
        
        return CGSizeMake(cellSizeWidth, cellSizeHeight + 2 * cellInsetMargin)
    }
    
    override func layout() {
        super.layout()
    }
    
    override func setUpSubNodesWithThread(thread: Thread) {
        super.setUpSubNodesWithThread(thread)
    }
}