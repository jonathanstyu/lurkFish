//
//  EmptyNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class EmptyNodeCell: ASCellNode {
    var emptyBodyTextNode: ASTextNode
    
    override init() {
        emptyBodyTextNode = ASTextNode()
        super.init()
        setupElements()
    }
    
    func setupElements() {
        emptyBodyTextNode.attributedString = NSAttributedString(string: "Hello there, this is the text of god", attributes: nil)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        let bodyTextLayoutSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [emptyBodyTextNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: bodyTextLayoutSpec)
    }
    
}