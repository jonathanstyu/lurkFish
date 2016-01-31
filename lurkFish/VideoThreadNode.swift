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
    var videoNode: JASNetworkImageNode
    
    var media: Media
    
    var videoTitleNode: ASTextNode
    var videoDescriptionNode: ASTextNode
    var videoProviderNode: ASTextNode
    
    var verticalVideoContainerStack: ASStackLayoutSpec
    
    override init(threadVM: ThreadViewModel) {
        media = threadVM.attachedMedia as Media!
        
        videoNode = JASNetworkImageNode()
        videoNode.URL = NSURL(string: media.thumbnail_url!)
        videoNode.backgroundColor = UIColor.flatGrayColor()
        
        videoTitleNode = ASTextNode()
        videoDescriptionNode = ASTextNode()
        videoProviderNode = ASTextNode()
        
        verticalVideoContainerStack = ASStackLayoutSpec()
        super.init(threadVM: threadVM)
        
        postType = "video"
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
//        I am arranging this in its organizational stack matter. Starting with the video node itself wrapped in its placeholder
        let videoPlaceHolder = ASRatioLayoutSpec(ratio: 0.75, child: videoNode)
        
//        I wrap this all into a vertical stack that I THEN will put into the main stack
        verticalVideoContainerStack = ASStackLayoutSpec(direction: .Vertical, spacing: 5.0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [videoPlaceHolder, videoTitleNode, videoDescriptionNode])
        verticalVideoContainerStack.flexGrow = true
        
        verticalNodeStack.setChildren([headerStack, titleNode, verticalVideoContainerStack, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }
    
    override func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
        super.setUpSubNodesWithThread(threadVM)
        videoTitleNode.attributedString = NSAttributedString(string: "\(media.title!)", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(12.0)
            ])
        
        videoProviderNode.attributedString = NSAttributedString(string: "\(media.provider_name!)", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(10.0)
            ])
        
        videoDescriptionNode.attributedString = NSAttributedString(string: "\(media.description!)", attributes: [
                NSForegroundColorAttributeName: UIColor.blackColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(10.0)
                ])
        
        addSubnode(videoNode)
        addSubnode(videoTitleNode)
        addSubnode(videoProviderNode)
        addSubnode(videoDescriptionNode)
    }
    
    override func attachTheaterNodeTag(indexPath: NSIndexPath) {
        videoNode.tag = indexPath.row
    }
    
    override func theaterNode() -> AnyObject {
        return videoNode
    }
    
}