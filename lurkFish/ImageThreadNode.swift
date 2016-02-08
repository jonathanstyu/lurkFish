//
//  ImageThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ImageThreadNode: ThreadNode, ASNetworkImageNodeDelegate {
    var imageNode: JASNetworkImageNode
    var imagePlaceHolder: ASRatioLayoutSpec?
    var imageNodeSize: CGSize!
    
    override init(threadVM: ThreadViewModel) {
        imageNode = JASNetworkImageNode()
        imageNode.placeholderColor = UIColor.flatGrayColor()
        super.init(threadVM: threadVM)
        imageNode.delegate = self
        
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
        
        if let image = imageNode.image {
            let imageSize = image.size
            imagePlaceHolder = ASRatioLayoutSpec(ratio: imageSize.height / imageSize.width, child: imageNode)
        } else {
            imagePlaceHolder = ASRatioLayoutSpec(ratio: 0.5, child: imageNode)
        }
        
        verticalNodeStack.setChildren([headerStack, titleNode])
        
//        Puts together the two halves so that we can have a photo that goes edge to edge
        let topHalf = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: insideMargin, right: cellInsetMargin), child: verticalNodeStack)
        let bottomHalf = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: insideMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: actionBarStack)
        
        return ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [topHalf, imagePlaceHolder!, bottomHalf])
    }    
    
    override func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
        super.setUpSubNodesWithThread(threadVM)
        
        if threadVM.url!.rangeOfString(".png") != nil || threadVM.url!.rangeOfString(".jpg") != nil {
            imageNode.URL = NSURL(string: threadVM.url!)
        } else if threadVM.preview != nil {
            let source: ImageURL = (threadVM.preview!.first?.source)!
            imageNode.URL = NSURL(string: source.url!)
        } else {
            imageNode.URL = NSURL(string: threadVM.url!)
        }
        
        
        addSubnode(imageNode)
    }
    
    override func attachTheaterNodeTag(indexPath: NSIndexPath) {
        imageNode.tag = indexPath.row
    }
    
    override func theaterNode() -> AnyObject {
        return imageNode
    }
    
    func imageNode(imageNode: ASNetworkImageNode!, didLoadImage image: UIImage!) {
//        When the imageNode within the core item gets fully loaded, we rerun the layout function and then it resizes itself.
        self.setNeedsLayout()
    }
    
}