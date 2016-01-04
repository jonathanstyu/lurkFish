//
//  ThreadNode.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import ChameleonFramework
import AsyncDisplayKit

class ThreadNode: ASCellNode {
    var titleNode: ASTextNode
    var commentsNode: ASTextNode
    var subredditNode: ASTextNode
    var opNode: ASTextNode
    var scoreNode: ASTextNode
    var dateSubmittedNode: ASTextNode
    var postLinkNode: ASTextNode
    
    var postType: String!
    
    var cellInsetMargin: CGFloat = 10.0
    var cellSizeWidth: CGFloat = 0.0
    var cellSizeHeight: CGFloat = 0.0
    var insideMargin: CGFloat = 10.0
    
    var actionBarStack: ASStackLayoutSpec!
    var verticalNodeStack: ASStackLayoutSpec!
    var headerStack: ASStackLayoutSpec!
    var headerBarStack: ASStackLayoutSpec!
    
    init(threadVM: ThreadViewModel) {
        titleNode = ASTextNode()
        commentsNode = ASTextNode()
        subredditNode = ASTextNode()
        opNode = ASTextNode()
        scoreNode = ASTextNode()
        dateSubmittedNode = ASTextNode()
        postLinkNode = ASTextNode()
        super.init()
        
        postType = "link"
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        
        headerBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [dateSubmittedNode, opNode, postLinkNode])
        
//        header that contains main header and more
        headerStack = ASStackLayoutSpec(direction: .Vertical, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [subredditNode, headerBarStack])
        
//        The bottom part of the entire cell
        actionBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [scoreNode, commentsNode])
        
//        The final stack that puts it all together
        verticalNodeStack = ASStackLayoutSpec()
        verticalNodeStack.direction = .Vertical
        verticalNodeStack.spacing = insideMargin
        verticalNodeStack.justifyContent = .Center
        verticalNodeStack.alignItems = .Start
        verticalNodeStack.setChildren([headerStack, titleNode, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }    
    
    func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
//        Body text attributes
        titleNode.attributedString = NSAttributedString(string: threadVM.title as String!, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 16.0)!
            ])
        
//        Header Bar Node Components

        subredditNode.attributedString = NSAttributedString(string: threadVM.subreddit as String!, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 18.0)!
            ])
        
        opNode.attributedString = NSAttributedString(string: "OP: \(threadVM.author as String!)", attributes: [
            NSForegroundColorAttributeName: UIColor.flatBlueColorDark(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont.boldSystemFontOfSize(12.0)
            ])
        
        dateSubmittedNode.attributedString = NSAttributedString(string: threadVM.date, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
        postLinkNode.attributedString = NSAttributedString(string: postType, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!,
            NSUnderlineStyleAttributeName: NSNumber(integer: 1)
            ])
        
//        FooterBar Node Components
        
        commentsNode.attributedString = NSAttributedString(string: "\(threadVM.numberOfComments!) Comments", attributes: [
            NSForegroundColorAttributeName: UIColor.flatGreenColorDark(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
        scoreNode.attributedString = NSAttributedString(string: "\(threadVM.score!)", attributes: [
            NSForegroundColorAttributeName: threadVM.scoreColor,
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Bold", size: 14.0)!
            ])
        
        
        addSubnode(titleNode)
        addSubnode(commentsNode)
        addSubnode(scoreNode)
        addSubnode(subredditNode)
        
        addSubnode(opNode)
        addSubnode(dateSubmittedNode)
        addSubnode(postLinkNode)
    }
}