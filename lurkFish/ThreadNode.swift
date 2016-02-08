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
    var titleNode: JASTextNode
    
    var commentsNode: ASTextNode
    var subredditNode: ASTextNode
    var opNode: ASTextNode
    var scoreNode: ASTextNode
    var dateSubmittedNode: ASTextNode
    var typeNode: ASTextNode
    
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
        titleNode = JASTextNode()
        commentsNode = ASTextNode()
        subredditNode = ASTextNode()
        opNode = ASTextNode()
        scoreNode = ASTextNode()
        dateSubmittedNode = ASTextNode()
        typeNode = ASTextNode()
        super.init()
        
        postType = threadVM.type
        setUpSubNodesWithThread(threadVM)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
//        holds the date submitted, the OP, and type 
        headerBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [dateSubmittedNode, opNode, typeNode])
        
//        header that contains main title and the info bar (set up above)
        headerStack = ASStackLayoutSpec(direction: .Vertical, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [subredditNode, headerBarStack])
        
//        The bottom part of the entire cell holding score + comments
        actionBarStack = ASStackLayoutSpec(direction: .Horizontal, spacing: insideMargin, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [scoreNode, commentsNode])
        
//        The final stack that puts it all together || note that theaterNode is invisible here but I am looking to add image/text
        verticalNodeStack = ASStackLayoutSpec()
        verticalNodeStack.direction = .Vertical
        verticalNodeStack.spacing = insideMargin
        verticalNodeStack.justifyContent = .Center
        verticalNodeStack.alignItems = .Start
        verticalNodeStack.setChildren([headerStack, titleNode, actionBarStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets.init(top: cellInsetMargin, left: cellInsetMargin, bottom: cellInsetMargin, right: cellInsetMargin), child: verticalNodeStack)
    }    
    
    func setUpSubNodesWithThread(threadVM: ThreadViewModel) {
//        Body text attributes, holding the title of the linked content
        titleNode.attributedString = NSAttributedString(string: threadVM.title as String!, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3),
            NSForegroundColorAttributeName: UIColor.blackColor()
            ])
        titleNode.placeholderColor = UIColor.flatBlackColor()
        
//        Header Bar Node Components [subreddit name, poster, date posted, and post link type] which gets wrapped up in speclayout later

        subredditNode.attributedString = NSAttributedString(string: threadVM.subreddit as String!, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),
            NSForegroundColorAttributeName: UIColor.blackColor()
            ])
        
        opNode.attributedString = NSAttributedString(string: "OP: \(threadVM.author as String!)", attributes: [
            NSForegroundColorAttributeName: UIColor.flatBlueColorDark(),
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
            ])
        
        dateSubmittedNode.attributedString = NSAttributedString(string: threadVM.date, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
            ])
        
        typeNode.attributedString = NSAttributedString(string: postType, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1),
            NSUnderlineStyleAttributeName: NSNumber(integer: 1)
            ])
        
//        FooterBar Node Components, holding the number of contents and judged score
        
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
        addSubnode(typeNode)
    }
    
    func attachTheaterNodeTag(indexPath: NSIndexPath) {
        titleNode.tag = indexPath.row
    }
    
    func theaterNode() -> AnyObject {
        return titleNode
    }
    
}