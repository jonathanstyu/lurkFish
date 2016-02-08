//
//  SyntaxTextStorage.swift
//  lurkFish
//
//  Created by Jonathan Yu on 2/1/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

class JYTextStorage: NSTextStorage {
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


    func applyStylesToRange(searchRange: NSRange) {
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody)
        let boldFontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor, size: 0)
        let normalFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
//        match items 
        let regexString = "(\\*\\w+(\\s\\w+)*\\*)"
        let regex = try! NSRegularExpression(pattern: regexString, options: [])
        let boldAttributes = [NSFontAttributeName: boldFont]
        let normalAttributes = [NSFontAttributeName: normalFont]
        
//        iterate over the matches 
        regex.enumerateMatchesInString(backingStorage.string, options: [], range: searchRange) { (match, flags, stop) -> Void in
            let matchRange = match?.rangeAtIndex(1)
            self.addAttributes(boldAttributes, range: matchRange!)
            
//            Reset
            let maxRange = (matchRange?.location)! + (matchRange?.length)!
            if maxRange + 1 < self.length {
                self.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
            }
        }
    }
    
}