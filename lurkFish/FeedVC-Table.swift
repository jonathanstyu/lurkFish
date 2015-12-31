//
//  FeedVC-Table.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension FeedViewController {
    
    func setUpTable() {
        threadTable = ASTableView(frame: CGRectZero, style: UITableViewStyle.Plain, asyncDataFetching: true)
        threadTable.asyncDataSource = self
        threadTable.asyncDelegate = self
        threadTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(threadTable)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return threadArray.count
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let currentThread = self.threadArray[indexPath.row]
        switch currentThread.post_hint {
        case "link"?:
            return ThreadNode(thread: currentThread)
        case "image"?:
            return ImageThreadNode(thread: currentThread)
        default:
            return ThreadNode(thread: currentThread)
        }
        
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print(self.threadArray[indexPath.row])
    }
    
}