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

class FeedItemManager: NSObject {
    var models: [Thread]
    var viewModels: [ThreadViewModel]
    var url: String
    var downloaded: Bool
    var after: String = ""
    
    init(type: String) {
        self.models = []
        self.viewModels = []
        self.url = "https://www.reddit.com/\(type).json"
        self.downloaded = false
        super.init()
    }
    
    func download(completion: (reloadOK: Bool) -> Void) {
        if after == "" {
            downloadModelItems(["":""]) { (downloaded) -> Void in
                completion(reloadOK: downloaded)
            }
        } else {
            downloadModelItems(["after": after]) { (downloaded) -> Void in
                completion(reloadOK: downloaded)
            }
        }
    }
    
    func downloadModelItems(parameters: [String: String]?, completion: (downloaded: Bool) -> Void) {
        Alamofire.request(.GET, url, parameters: parameters).responseObject { (response: Response<RedditResponse, NSError>) -> Void in
            let rawredditdata = response.result.value
            if let children = rawredditdata!.children {
                self.models += children
                self.after = rawredditdata!.after!
                self.convertToViewModels()
                completion(downloaded: true)
            }
        }
    }
    
    func convertToViewModels() {
        for model in self.models {
            self.viewModels.append(ThreadViewModel(thread: model))
        }
    }
    
    func count() -> Int {
        return self.viewModels.count
    }
    
}