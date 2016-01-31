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
    
    override init(threadVM: ThreadViewModel) {
        super.init(threadVM: threadVM)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let bodyTextStorage = NSTextStorage(string: self.threadVM!.title! + self.threadVM!.bodyText!)
        
        let textLayoutManager = NSLayoutManager()
        
        let textContainer = NSTextContainer(size: CGSize.zero)
        
        textLayoutManager.addTextContainer(textContainer)
        
        bodyTextStorage.addLayoutManager(textLayoutManager)
        
        let textView = UITextView(frame: self.view.bounds, textContainer: textContainer)
        textView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.editable = false
        self.view.addSubview(textView)
    }
    
}