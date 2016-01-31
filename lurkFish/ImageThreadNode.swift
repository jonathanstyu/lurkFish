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
    var imageNode: JASNetworkImageNode
    var imageNodeSize: CGSize!
    
    override init(threadVM: ThreadViewModel) {
        imageNode = JASNetworkImageNode()
        imageNode.URL = NSURL(string: threadVM.url!)
        imageNode.backgroundColor = UIColor.flatGrayColor()
        super.init(threadVM: threadVM)
        
        postType = "image"
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
        
        let imagePlaceHolder = ASRatioLayoutSpec(ratio: 1.0, child: imageNode)
        
        verticalNodeStack.setChildren([headerStack, titleNode])
        
//        Puts together the two halves so that we can have a photo that goes edge to edge
        let topHalf = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: insideMargin, right: cellInsetMargin), child: verticalNodeStack)
        let bottomHalf = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: insideMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: actionBarStack)
        
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [topHalf, imagePlaceHolder, bottomHalf])
    }    
    
    override func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
        super.setUpSubNodesWithThread(threadVM)
                
        addSubnode(imageNode)
    }
    
    override func attachTheaterNodeTag(indexPath: NSIndexPath) {
        imageNode.tag = indexPath.row
    }
    
    override func theaterNode() -> AnyObject {
        return imageNode
    }
}