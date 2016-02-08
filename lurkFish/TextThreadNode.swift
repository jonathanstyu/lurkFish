//
//  TextThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/17/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TextThreadNode: ThreadNode {
    var bodyTextNode: JASTextNode
    
    var verticalTextLayoutSpec: ASStackLayoutSpec
    
    override init(threadVM: ThreadViewModel) {
        bodyTextNode = JASTextNode()
        verticalTextLayoutSpec = ASStackLayoutSpec()
        super.init(threadVM: threadVM)
        
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        super.layoutSpecThatFits(constrainedSize)
        
        verticalTextLayoutSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10.0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [bodyTextNode])
        
        let textInsetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalTextLayoutSpec)
        
        verticalNodeStack.setChildren([headerStack, titleNode, textInsetSpec, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }
    
    override func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
        super.setUpSubNodesWithThread(threadVM)
        let bodyStringAttributes: [String : AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding,
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        ]
        bodyTextNode.attributedString = NSAttributedString(string: threadVM.bodyText!, attributes: bodyStringAttributes)
        bodyTextNode.maximumNumberOfLines = 6
        bodyTextNode.shadowColor = UIColor.blackColor().CGColor
        bodyTextNode.shadowOffset = CGSize(width: 5.0, height: 5.0)
        bodyTextNode.shadowRadius = 5.0
        addSubnode(bodyTextNode)
    }
    
    override func attachTheaterNodeTag(indexPath: NSIndexPath) {
        bodyTextNode.tag = indexPath.row
    }
    
    override func theaterNode() -> AnyObject {
        return bodyTextNode
    }

}