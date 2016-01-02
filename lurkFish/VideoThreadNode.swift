//
//  VideoThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/1/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class VideoThreadNode: ThreadNode {
    var videoNode: ASNetworkImageNode
    
    var media: Media
    
    var videoTypeNode: ASTextNode
    var videoDescriptionNode: ASTextNode
    
    var videoBarStack: ASStackLayoutSpec
    
    override init(thread: Thread) {
        media = thread.media as Media!
        
        videoNode = ASNetworkImageNode()
        videoNode.URL = NSURL(string: media.thumbnail_url!)
        videoNode.backgroundColor = UIColor.flatGrayColor()
        
        videoTypeNode = ASTextNode()
        videoDescriptionNode = ASTextNode()
        
        videoBarStack = ASStackLayoutSpec()
        super.init(thread: thread)
        
        postType = "video"
        setUpSubNodesWithThread(thread)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
        
//        videoBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [videoTypeNode])
        
        let videoPlaceHolder = ASRatioLayoutSpec(ratio: 0.75, child: videoNode)
        
        verticalNodeStack.setChildren([headerStack, titleNode, videoPlaceHolder, videoTypeNode, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }
    
    override func setUpSubNodesWithThread(thread: Thread) {
        super.setUpSubNodesWithThread(thread)
        videoTypeNode.attributedString = NSAttributedString(string: "\(media.provider_name!) :: \(media.title!)", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Bold", size: 10.0)!
            ])
        
//        videoDescriptionNode.attributedString = NSAttributedString(string: "\(media.provider_name!)", attributes: [
//            NSForegroundColorAttributeName: UIColor.blackColor(),
//            NSFontAttributeName: UIFont(name: ".SFUIText-Bold", size: 10.0)!
//            ])
        
        addSubnode(videoNode)
        addSubnode(videoTypeNode)
    }
    
}