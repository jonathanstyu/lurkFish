//
//  ImageURL.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageURL: Mappable {
    var url: String?
    var width: Int?
    var height: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
    }
}