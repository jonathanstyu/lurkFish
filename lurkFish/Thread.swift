//
//  Thread.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class Thread: Mappable {
    var kind: String?
    var domain: String?
    var banned_by: String?
    var subreddit: String?
    var id: String?
    var gilded: Int?
    var archived: Bool?
    var clicked: Bool?
    var author: String?
    var num_comments: Int?
    var score: Int?
    var over_18: Bool?
    var hidden: Bool?
    var thumbnail: String?
    var subreddit_id: String?
    var link_flair_text: String?
    var edited: Bool?
    var downs: Int?
    var saved: Bool?
    var post_hint: String?
    var stickied: Bool?
    var permalink: String?
    var locked: Bool?
    var url: String?
    var title: String?
    var created_utc: NSDate?
    var visited: Bool?
    var ups: Int?
    var preview: [ImageContainer]?
    var media: Media?
    var selftext_html: String?
    var selftext_text: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        domain <- map["data.domain"]
        banned_by <- map["data.banned_by"]
        subreddit <- map["data.subreddit"]
        id <- map["data.id"]
        gilded <- map["data.gilded"]
        archived <- map["data.archived"]
        clicked <- map["data.clicked"]
        author <- map["data.author"]
        num_comments <- map["data.num_comments"]
        score <- map["data.score"]
        over_18 <- map["data.over_18"]
        hidden <- map["data.hidden"]
        link_flair_text <- map["data.link_flair_text"]
        thumbnail <- map["data.thumbnail"]
        subreddit_id <- map["data.subreddit_id"]
        edited <- map["data.edited"]
        downs <- map["data.downs"]
        saved <- map["data.saved"]
        post_hint <- map["data.post_hint"]
        stickied <- map["data.stickied"]
        permalink <- map["data.permalink"]
        locked <- map["data.locked"]
        url <- map["data.url"]
        title <- map["data.title"]
        created_utc <- (map["data.created_utc"], DateTransform())
        visited <- map["data.visited"]
        ups <- map["data.ups"]
        preview <- map["data.preview.images"]
        media <- map["data.media.oembed"]
        selftext_html <- map["data.selftext_html"]
        selftext_text <- map["data.selftext"]
    }
}