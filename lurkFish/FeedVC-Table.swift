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
        let currentThreadVM = ThreadViewModel(thread: self.threadArray[indexPath.row])
        switch currentThreadVM.type {
        case "link"?:
            return ThreadNode(threadVM: currentThreadVM)
        case "image"?:
            return ImageThreadNode(threadVM: currentThreadVM)
        case "rich:video"?:
            return VideoThreadNode(threadVM: currentThreadVM)
        default:
            return ThreadNode(threadVM: currentThreadVM)
        }
        
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        print(self.threadArray[indexPath.row])
    }
    
}