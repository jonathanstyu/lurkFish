//
//  TextContentVC.swift
//  lurkFish
//
//  Created by Jonathan Yu on 1/31/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class TextContentViewController: ContentViewController {
    var textView: UITextView!
    
    override init(threadVM: ThreadViewModel) {
        super.init(threadVM: threadVM)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.flatWhiteColor()
        setupText()
    }
    
    func setupText() {
        let stringContent = self.threadVM!.title! + "\n" + self.threadVM!.bodyText!
        let attrs = [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        ]
        let attrsString = NSMutableAttributedString(string: stringContent, attributes: attrs)
        let bodyTextStorage = SyntaxTextStorage()
        let textLayoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let paraStyle = NSMutableParagraphStyle()
        
        paraStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        attrsString.addAttribute(NSFontAttributeName, value: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), range: NSRange(location: 0, length: (self.threadVM!.title! as NSString).length))
//        attrsString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSRange(location: 0, length: attrsString.length))
        bodyTextStorage.appendAttributedString(attrsString)
        textLayoutManager.addTextContainer(textContainer)
        bodyTextStorage.addLayoutManager(textLayoutManager)
        
        textView = UITextView(frame: CGRectInset(self.view.bounds, 5.0, 5.0), textContainer: textContainer)
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textView.editable = false
        textView.backgroundColor = UIColor.flatWhiteColor()
        self.view.addSubview(textView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
//    
    func preferredContentSizeChanged(notification: NSNotification) {
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
}