//
//  RedditResponse.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/27/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class RedditResponse: Mappable {
    var modhash: String?
    var children: [Thread]?
    var after: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        modhash <- map["data.modhash"]
        children <- map["data.children"]
        after <- map["data.after"]
    }
}