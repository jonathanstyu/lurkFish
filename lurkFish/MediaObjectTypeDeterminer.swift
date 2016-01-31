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
    
    static func determineNodeCellType(threadVM: ThreadViewModel) -> ThreadNode {
        switch threadVM.type {
        case "link"?:
            return ThreadNode(threadVM: threadVM)
        case "text"?:
            return TextThreadNode(threadVM: threadVM)
        case "image"?:
            return ImageThreadNode(threadVM: threadVM)
        case "rich:video"?:
            return VideoThreadNode(threadVM: threadVM)
        default:
            return ThreadNode(threadVM: threadVM)
        }
    }
    
    static func determineContentViewer(threadVM: ThreadViewModel) -> ContentViewController {
        switch threadVM.type {
        case "link"?:
            return ContentViewController(threadVM: threadVM)
        case "text"?:
            return ContentViewController(threadVM: threadVM)
//        case "image"?:
//            return ImageThreadNode(threadVM: threadVM)
//        case "rich:video"?:
//            return VideoThreadNode(threadVM: threadVM)
        default:
            return ContentViewController(threadVM: threadVM)
        }
    }
}