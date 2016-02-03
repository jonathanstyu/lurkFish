//
//  SyntaxTextStorage.swift
//  lurkFish
//
//  Created by Jonathan Yu on 2/1/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

class SyntaxTextStorage: NSTextStorage {
    let backingStorage = NSMutableAttributedString()
    override var string: String {
        return backingStorage.string
    }
    
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [String : AnyObject] {
        return backingStorage.attributesAtIndex(location, effectiveRange: range)
    }
    
//    Replaces the default NSTextstorage things with the backingstorage
    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        beginEditing()
        backingStorage.replaceCharactersInRange(range, withString: str)
        edited([.EditedCharacters, .EditedAttributes], range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func setAttributes(attrs: [String : AnyObject]?, range: NSRange) {
        beginEditing()
        backingStorage.setAttributes(attrs, range: range)
        edited(.EditedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
//    func applyStylesToRange(searchRange: Range) {
//        
//    }
    
}