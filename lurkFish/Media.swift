//
//  Video.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/1/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class Media: Mappable {
    var type: String?
    var provider_url: String?
    var title: String?
    var url: String?
    var description: String?
    var author_name: String?
    var height: Int?
    var width: Int?
    var html: String?
    var thumbnail_width: Int?
    var version: String?
    var provider_name: String?
    var thumbnail_url: String?
    var thumbnail_height: String?
    var author_url: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        provider_url <- map["provider_url"]
        title <- map["title"]
        url <- map["url"]
        description <- map["description"]
        author_name <- map["author_name"]
        height <- map["height"]
        width <- map["width"]
        html <- map["html"]
        thumbnail_width <- map["thumbnail_width"]
        thumbnail_height <- map["thumbnail_height"]
        version <- map["version"]
        provider_name <- map["provider_name"]
        thumbnail_url <- map["thumbnail_url"]
        author_url <- map["author_url"]
    }
}