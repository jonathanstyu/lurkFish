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
    var bodyTextNode: ASTextNode
    
    var verticalTextLayoutSpec: ASStackLayoutSpec
    
    override init(threadVM: ThreadViewModel) {
        bodyTextNode = ASTextNode()
        verticalTextLayoutSpec = ASStackLayoutSpec()
        super.init(threadVM: threadVM)
        
        postType = "text"
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
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        bodyTextNode.attributedString = NSAttributedString(string: threadVM.bodyText!, attributes: bodyStringAttributes)
        bodyTextNode.maximumNumberOfLines = 6
        bodyTextNode.addTarget(self, action: "tappedTextNode:", forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        addSubnode(bodyTextNode)
    }
    
    func tappedTextNode(textNode: ASTextNode) {
        print(textNode.frame)
        UIView.animateWithDuration(0.5) { () -> Void in
            textNode.bounds = CGRect(x: 0, y: 0, width: 100, height: 500)
        }
        print(textNode.frame)
    }
}