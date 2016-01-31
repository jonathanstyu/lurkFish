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
        return self.dataSource.count()
    }
    
    func tableView(tableView: ASTableView!, nodeForRowAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        let currentThreadNodeCell: ThreadNode
        
        if self.dataSource.downloaded {
            let currentThreadVM = self.dataSource.viewModels[indexPath.row]
            currentThreadNodeCell = MediaObjectTypeDeterminer.determineNodeCellType(currentThreadVM)
            currentThreadNodeCell.attachTheaterNodeTag(indexPath)
            currentThreadNodeCell.theaterNode().addTarget(self, action: "theaterTapped:", forControlEvents: ASControlNodeEvent.TouchUpInside)
        } else {
            return EmptyNodeCell()
        }
        
        return currentThreadNodeCell
    }
    
    func theaterTapped(sender: AnyObject) {
        let currentThread = self.dataSource.viewModels[sender.tag]
        let contentViewer = ContentViewController(threadVM: currentThread)
        self.navigationController?.pushViewController(contentViewer, animated: true)
    }
    
}