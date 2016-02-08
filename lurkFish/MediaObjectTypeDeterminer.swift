//
//  MediaObjectTypeDeterminer.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/31/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

struct MediaObjectTypeDeterminer {
    
    static func determineThreadType(thread: Thread) -> String {
        if thread.selftext_html != nil {
            return "text"
        } else if thread.url!.rangeOfString("gif") != nil {
            return "gif"
        } else {
            switch thread.post_hint {
            case "link"?:
                return "link"
            case "text"?:
                return "text"
            case "image"?:
                return "image"
            case "rich:video"?:
                return "rich:video"
            default:
                return "empty"
            }
        }
    }
    
    static func determineNodeCellType(threadVM: ThreadViewModel) -> ThreadNode {
        switch threadVM.type {
        case "link":
            return ThreadNode(threadVM: threadVM)
        case "text":
            return TextThreadNode(threadVM: threadVM)
        case "image":
            return ImageThreadNode(threadVM: threadVM)
        case "rich:video":
            return VideoThreadNode(threadVM: threadVM)
        case "gif":
            return VideoThreadNode(threadVM: threadVM)
        default:
            return ThreadNode(threadVM: threadVM)
        }
    }    

}