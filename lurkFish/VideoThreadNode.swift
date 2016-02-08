//
//  VideoThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/1/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import FLAnimatedImage

class VideoThreadNode: ThreadNode, ASNetworkImageNodeDelegate {
    var videoNode: JASNetworkImageNode
    
    var media: Media
    
    var videoURL: String
    
    var videoTitleNode: ASTextNode
    var videoDescriptionNode: ASTextNode
    var videoProviderNode: ASTextNode
    
    var verticalVideoContainerStack: ASStackLayoutSpec
    
    var vidPlaying = false
    
    override init(threadVM: ThreadViewModel) {
        media = threadVM.attachedMedia as Media!
        videoURL = threadVM.url as String!
        
        videoNode = JASNetworkImageNode()
        videoNode.URL = NSURL(string: media.thumbnail_url!)
        videoNode.backgroundColor = UIColor.flatGrayColor()
        
        videoTitleNode = ASTextNode()
        videoDescriptionNode = ASTextNode()
        videoProviderNode = ASTextNode()
        
        verticalVideoContainerStack = ASStackLayoutSpec()
        super.init(threadVM: threadVM)
        
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
//        I am arranging this in its organizational stack matter. Starting with the video node itself wrapped in its placeholder
        let videoPlaceHolder: ASRatioLayoutSpec!
        if let image = videoNode.image {
            let imageSize = image.size
            videoPlaceHolder = ASRatioLayoutSpec(ratio: imageSize.height / imageSize.width, child: videoNode)
        } else {
            videoPlaceHolder = ASRatioLayoutSpec(ratio: 0.5, child: videoNode)
        }
        
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
        
        videoNode.addTarget(self, action: "theatertapped:", forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        addSubnode(videoNode)
        addSubnode(videoTitleNode)
        addSubnode(videoProviderNode)
        addSubnode(videoDescriptionNode)
    }
    
    func theatertapped(sender: AnyObject) {
        
        if !vidPlaying {
            if videoURL.rangeOfString("gif") != nil {
                print(videoURL)
                vidPlaying = true
                let gifImage = FLAnimatedImage(animatedGIFData: NSData(contentsOfURL: NSURL(string: videoURL)!))
                let gifImageView = FLAnimatedImageView(frame: videoNode.bounds)
                gifImageView.animatedImage = gifImage
                videoNode.view.addSubview(gifImageView)
            }
        }
        
    }
    
    func imageNode(imageNode: ASNetworkImageNode!, didLoadImage image: UIImage!) {
        self.setNeedsLayout()
    }    
    
    override func attachTheaterNodeTag(indexPath: NSIndexPath) {
        videoNode.tag = indexPath.row
    }
    
    override func theaterNode() -> AnyObject {
        return videoNode
    }
    
}