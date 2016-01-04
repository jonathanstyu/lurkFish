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
    var type: String?
    var numberOfComments: String?
    var score: String?
    var postType: String?
    var author: String?
    var subreddit: String?
    var url: String?
    var title: String?
    
    var scoreColor: UIColor!
    
    init(thread: Thread) {
        self.thread = thread
        self.date = NSDateFormatter.localizedStringFromDate(thread.created_utc!, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
        self.numberOfComments = String(thread.num_comments!)
        self.type = thread.post_hint
        self.author = thread.author
        self.subreddit = thread.subreddit
        self.url = thread.url
        self.title = thread.title
        self.score = String(thread.score!)
        if self.thread?.media != nil {
            self.attachedMedia = thread.media!
        }
        
        switch thread.score! {
        case let x where x > 5000:
            self.scoreColor = UIColor.flatRedColor()
        case 4000..<5000:
            self.scoreColor = UIColor.flatOrangeColorDark()
        case 300..<4000:
            self.scoreColor = UIColor.flatWatermelonColorDark()
        case 2000..<3000:
            self.scoreColor = UIColor.flatMagentaColorDark()
        case 1000..<2000:
            self.scoreColor = UIColor.flatGrayColorDark()
        default:
            self.scoreColor = UIColor.blackColor()
        }
    }
    
}