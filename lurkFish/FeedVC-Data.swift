//
//  FeedVC-Data.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import AsyncDisplayKit

extension FeedViewController {
    
    func downloadRedditData() {
        self.dataSource = FeedItemManager(type: type)
        dataSource.download { (reloadOK) -> Void in
            if reloadOK {
                self.threadTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    func tableView(tableView: ASTableView!, willBeginBatchFetchWithContext context: ASBatchContext!) {
        let oldItemCount = self.dataSource.count()
        dataSource.download { (reloadOK) -> Void in
            if reloadOK {
//                Count the range from the old table count to the new one
                let insertRowRange = oldItemCount..<self.dataSource.count()
                let insertRowPaths = insertRowRange.map { NSIndexPath(forRow: $0, inSection: 0) }
                self.threadTable.insertRowsAtIndexPaths(insertRowPaths, withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
}