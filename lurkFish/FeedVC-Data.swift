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

extension FeedViewController {
    
    func downloadRedditData() {
        self.dataSource = FeedDataItems(type: type)
        dataSource.downloadModelItems { (downloaded) -> Void in
            if downloaded {
//                self.threadTable.reloadData()
//                So that I can get that nice fade in effect
                self.threadTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
}