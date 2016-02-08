//
//  FeedVC-Table.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import FLAnimatedImage

extension FeedViewController {
    
    func setUpTable() {
        threadTable = ASTableView(frame: CGRectZero, style: UITableViewStyle.Plain, asyncDataFetching: true)
        threadTable.asyncDataSource = self
        threadTable.asyncDelegate = self
        threadTable.backgroundColor = UIColor.flatWhiteColor()
        threadTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(threadTable)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count()
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let currentThreadNodeCell: ThreadNode
        let currentThreadVM = self.dataSource.viewModels[indexPath.row]
        currentThreadNodeCell = MediaObjectTypeDeterminer.determineNodeCellType(currentThreadVM)
        currentThreadNodeCell.attachTheaterNodeTag(indexPath)
        currentThreadNodeCell.selectionStyle = UITableViewCellSelectionStyle.None
        currentThreadNodeCell.theaterNode().addTarget(self, action: "theaterTapped:", forControlEvents: ASControlNodeEvent.TouchUpInside)
        
        return currentThreadNodeCell
    }
    
    func theaterTapped(sender: AnyObject) {
        let currentThread = self.dataSource.viewModels[sender.tag]
        let contentViewer: ContentViewController
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            (sender as! ASDisplayNode).backgroundColor = UIColor.flatWhiteColorDark()
            }) { (completed) -> Void in
                (sender as! ASDisplayNode).backgroundColor = UIColor.flatWhiteColor()
        }
        
        switch currentThread.type {
        case "link"?:
            contentViewer = WeblinkContentViewController(threadVM: currentThread)
            self.navigationController?.pushViewController(contentViewer, animated: true)
            print(currentThread.url!)
        case "text"?:
            contentViewer = TextContentViewController(threadVM: currentThread)
            self.navigationController?.pushViewController(contentViewer, animated: true)
        case "image"?:
            let imageView = sender as! JASNetworkImageNode
            contentViewer = PhotoContentViewController(threadVM: currentThread, image: imageView.image)
            self.navigationController?.pushViewController(contentViewer, animated: true)
        case "rich:video"?:
            break
        default:
            contentViewer = ContentViewController(threadVM: currentThread)
        }
    }
    
}