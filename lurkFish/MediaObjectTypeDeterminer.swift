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
        } else if thread.url!.rangeOfString(".gif") != nil {
            return "gif"
        } else if thread.url!.rangeOfString(".jpg") != nil || thread.url!.rangeOfString(".png") != nil {
            return "image"
        } else if thread.url != nil {
            return "link"
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
            if threadVM.preview != nil {
                return ImageThreadNode(threadVM: threadVM)
            } else {
                return ThreadNode(threadVM: threadVM)
            }
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