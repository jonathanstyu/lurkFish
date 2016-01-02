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
    
//    var actionBarNode: ASDisplayNode
    
    var cellInsetMargin: CGFloat = 10.0
    var cellSizeWidth: CGFloat = 0.0
    var cellSizeHeight: CGFloat = 0.0
    var insideMargin: CGFloat = 10.0
    
    var actionBarStack: ASStackLayoutSpec!
    var verticalNodeStack: ASStackLayoutSpec!
    var headerStack: ASStackLayoutSpec!
    var headerBarStack: ASStackLayoutSpec!
    
    init(thread: Thread) {
        titleNode = ASTextNode()
        commentsNode = ASTextNode()
        subredditNode = ASTextNode()
        opNode = ASTextNode()
        scoreNode = ASTextNode()
        dateSubmittedNode = ASTextNode()
        postLinkNode = ASTextNode()
        super.init()
        
        postType = "link"
        setUpSubNodesWithThread(thread)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        
        headerBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [dateSubmittedNode, opNode, postLinkNode])
        
        actionBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [scoreNode, commentsNode])
        
//        header
        headerStack = ASStackLayoutSpec(direction: .Vertical, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [subredditNode, headerBarStack])
        
//        The final stack that puts it all together
        verticalNodeStack = ASStackLayoutSpec()
        verticalNodeStack.direction = .Vertical
        verticalNodeStack.spacing = insideMargin
        verticalNodeStack.justifyContent = .Center
        verticalNodeStack.alignItems = .Start
        verticalNodeStack.setChildren([headerStack, titleNode, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }
    
//    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
//        let titleNodeSize = titleNode.measure(CGSize(
//            width: constrainedSize.width - 10.0,
//            height: constrainedSize.height * (2/3) ))
//        _ = upCountNode.measure(CGSize(
//            width: constrainedSize.width,
//            height: actionBarHeight))
//        _ = downCountNode.measure(CGSize(
//            width: constrainedSize.width,
//            height: actionBarHeight))
//        
//        cellSizeHeight += (titleNodeSize.height + actionBarHeight + insideMargin)
//        cellSizeWidth = constrainedSize.width
//        
//        return CGSizeMake(constrainedSize.width, cellSizeHeight + cellInsetMargin)
//    }
//    
//    override func layout() {
//        
//        titleNode.frame = CGRectMake(cellInsetMargin, cellInsetMargin, titleNode.calculatedSize.width, titleNode.calculatedSize.height)
//        actionBarNode.frame = CGRectMake(0, self.frame.maxY - actionBarHeight, cellSizeWidth, actionBarHeight)
//        upCountNode.frame = CGRect(origin: CGPoint(
//            x: cellInsetMargin,
//            y: 0),
//            size: upCountNode.calculatedSize)
//        downCountNode.frame = CGRect(origin: CGPoint(
//            x: upCountNode.frame.maxX + insideMargin * 2,
//            y: 0),
//            size: downCountNode.calculatedSize)
//    }
    
    func setUpSubNodesWithThread(thread: Thread) {
        titleNode.attributedString = NSAttributedString(string: thread.title as String!, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 16.0)!
            ])
        
//        Header Bar Node Components

        subredditNode.attributedString = NSAttributedString(string: thread.subreddit as String!, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue,
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 18.0)!
            ])
        
        opNode.attributedString = NSAttributedString(string: "OP: \(thread.author as String!)", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
        dateSubmittedNode.attributedString = NSAttributedString(string: "Submitted: \(NSDateFormatter.localizedStringFromDate(thread.created_utc!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle))", attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
        postLinkNode.attributedString = NSAttributedString(string: postType, attributes: [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
//        FooterBar Node Components
        
        commentsNode.attributedString = NSAttributedString(string: "\(thread.num_comments!) Comments", attributes: [
            NSForegroundColorAttributeName: UIColor.flatGreenColorDark(),
            NSBackgroundColorAttributeName: UIColor.clearColor(),
            NSFontAttributeName: UIFont(name: ".SFUIText-Medium", size: 12.0)!
            ])
        
        scoreNode.attributedString = NSAttributedString(string: "\(thread.score!)", attributes: [
            NSForegroundColorAttributeName: UIColor.flatGreenColorDark(),
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