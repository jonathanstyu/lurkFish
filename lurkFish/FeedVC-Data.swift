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
        let url = "https://www.reddit.com/\(type).json"
        Alamofire.request(.GET, url).responseObject { (response: Response<RedditResponse, NSError>) -> Void in
            let rawredditdata = response.result.value
            if let children = rawredditdata!.children {
                self.threadArray += children
                self.threadTable.reloadData()
            }
        }
    }
}