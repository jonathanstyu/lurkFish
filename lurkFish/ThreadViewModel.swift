//
//  ThreadViewModel.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/3/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

class ThreadViewModel: NSObject {
    
    var thread: Thread?
    var attachedMedia: Media?
    
    var date: String!
    var type: String!
    var numberOfComments: String?
    var score: String?
    var author: String?
    var subreddit: String?
    var url: String?
    var title: String?
    var bodyText: String?
    var preview: [ImageContainer]?
    
    var scoreColor: UIColor!    
    
    init(thread: Thread) {
        self.thread = thread
        date = NSDateFormatter.localizedStringFromDate(thread.created_utc!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        numberOfComments = String(thread.num_comments!)
        author = thread.author
        subreddit = thread.subreddit
        url = thread.url
        title = thread.title
        score = String(thread.score!)
        type = MediaObjectTypeDeterminer.determineThreadType(thread)
        
        if type == "text" {
            self.bodyText = thread.selftext_text
        }
        
        if self.thread?.media != nil {
            self.attachedMedia = thread.media!
        }
        
        if self.thread?.preview != nil {
            self.preview = thread.preview!
        }
        
        scoreColor = UIColor.flatOrangeColorDark()
    }
    
}