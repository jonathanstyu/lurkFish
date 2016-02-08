//
//  ImageContainer.swift
//  lurkFish
//
//  Created by Jonathan Yu on 12/31/15.
//  Copyright © 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class ImageContainer: Mappable {
    var source: ImageURL?
    var resolutions: [ImageURL]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        source <- map["source"]
        resolutions <- map["resolutions"]
    }

}