//
//  FeedDataSource.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class FeedDataItems: NSObject {
    var models: [Thread]
    var viewModels: [ThreadViewModel]
    var url: String
    var downloaded: Bool
    
    init(type: String) {
        self.models = []
        self.viewModels = []
        self.url = "https://www.reddit.com/\(type).json"
        self.downloaded = false
        super.init()
    }
    
    func downloadModelItems(completion: (downloaded: Bool) -> Void) {
        Alamofire.request(.GET, url).responseObject { (response: Response<RedditResponse, NSError>) -> Void in
            let rawredditdata = response.result.value
            if let children = rawredditdata!.children {
                self.models += children
                self.convertToViewModels()
                self.downloaded = true
                completion(downloaded: self.downloaded)
            }
        }
    }
    
    func convertToViewModels() {
        for model in self.models {
            self.viewModels.append(ThreadViewModel(thread: model))
        }
    }
    
    func count() -> Int {
        if downloaded {
            return self.viewModels.count
        } else {
            return 4
        }
    }
}