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
    var imageNode: ASNetworkImageNode
    var imageNodeSize: CGSize!
    
    override init(thread: Thread) {
        imageNode = ASNetworkImageNode()
        imageNode.URL = NSURL(string: thread.url!)
        imageNode.backgroundColor = UIColor.flatGrayColor()
        super.init(thread: thread)
        
        postType = "image"
        setUpSubNodesWithThread(thread)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
        
        let imagePlaceHolder = ASRatioLayoutSpec(ratio: 0.75, child: imageNode)
        
        verticalNodeStack.setChildren([headerStack, titleNode, imagePlaceHolder, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }
    
//    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
//        super.calculateSizeThatFits(constrainedSize)
//        let imageNodeSize = CGSize(width: cellSizeWidth, height: cellSizeWidth / 2.3)
//        cellSizeHeight += 2 * insideMargin + (cellSizeWidth / 2.3)
//        return CGSizeMake(cellSizeWidth, cellSizeHeight + cellInsetMargin)
//    }
    
//    override func layout() {
//        super.layout()
//        
//        imageNode.frame = CGRect(x: 0, y: titleNode.frame.maxY + insideMargin, width: cellSizeWidth, height: cellSizeWidth / 2.3)
//    }
    
    override func setUpSubNodesWithThread(thread: Thread) {
        super.setUpSubNodesWithThread(thread)
                
        addSubnode(imageNode)
    }
}